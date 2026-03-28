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
    # プログレスバーを表示するための変数
    @total_hours = (current_user.total_learning_minutes / 60.0).round(1)
    @next_threshold = current_user.next_threshold

    @tag_summaries = current_user.tags.map do |tag|
      {
        name: tag.name,
        hours: (current_user.total_learning_minutes_by_tag(tag) / 60.0).round(1)
      }
    end
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params) # 属性を更新するが保存しない
    theme = @user.learning_themes.first_or_initialize # すでに learning_themes があればそれを、なければ新規で用意する
    theme.name = params[:learning_theme_name].presence

    ActiveRecord::Base.transaction do
      # このブロック内の処理は「全部成功」か「全部失敗」のどちらかになる
      # @user.save! が失敗 → theme.save! は実行されず、@user の変更も取り消される
      # theme.save! が失敗 → @user の変更も取り消される
      # → どちらかが失敗した場合、DBは transaction 実行前の状態に戻る（ロールバック）
      @user.save!
      theme.save! # save 成功時は次の行へ、失敗時は例外 (Rescue) へ飛ぶ
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
