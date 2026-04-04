class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    ActiveRecord::Base.transaction do
      # このブロック内の処理は「全部成功」か「全部失敗」のどちらかになる
      # @user.save! が失敗 → theme.save! は実行されず、@user の登録も取り消される
      # learning_themes.create! が失敗 → @user の登録も取り消される
      # → どちらかが失敗した場合、DBは transaction 実行前の状態に戻る（ロールバック）
      @user.save!
      @user.learning_themes.create!(name: params[:learning_theme_name].presence)
    end

    auto_login(@user)
    redirect_to user_path(current_user), notice: "登録が完了しました"
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def show
    # ユーザープロフィール画面では、ユーザーの学習テーマとタグごとの学習時間を表示するためにデータを準備する
    @learning_themes = current_user.learning_themes

    # 各 learning_theme ごとにタグの学習時間を計算してまとめる
    @tag_summaries_by_theme = @learning_themes.each_with_object({}) do |theme, hash|
      hash[theme.id] = theme.tags.map do |tag|
        {
          name: tag.name,
          hours: (current_user.total_learning_minutes_by_tag(tag) / 60.0).round(1)
        }
      end
    end
  end

  def edit
    # 編集画面では、最初の learning_theme を表示する（複数登録されている場合も最初のものだけ編集可能）
    @learning_theme = current_user.learning_themes.first
  end

  def update
    @user.assign_attributes(user_params) # 属性を更新するが保存しない

    theme_names = params[:learning_theme_names].reject(&:blank?) # 空の入力を除外してテーマ名を更新

    ActiveRecord::Base.transaction do
      # このブロック内の処理は「全部成功」か「全部失敗」のどちらかになる
      # @user.save! が失敗 → theme.save! は実行されず、@user の変更も取り消される
      # theme.save! が失敗 → @user の変更も取り消される
      # → どちらかが失敗した場合、DBは transaction 実行前の状態に戻る（ロールバック）
      @user.save!

      # 既存テーマを更新 / 新規テーマを追加
      theme_names.each_with_index do |name, i|
        theme = current_user.learning_themes[i] || current_user.learning_themes.build
        theme.name = name
        theme.save!
      end

      # 送信されたテーマ数より多い既存テーマは削除する
      if current_user.learning_themes.size > theme_names.size
        current_user.learning_themes[theme_names.size..].each(&:destroy!)
      end
    end

    redirect_to user_path(current_user), notice: "ユーザー情報を更新しました"
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @user.destroy
    logout
    redirect_to root_path, notice: "ユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end
