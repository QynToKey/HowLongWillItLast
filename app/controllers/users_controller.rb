class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to user_path(current_user), notice: "登録が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
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
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "ユーザー情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    logout
    redirect_to root_path, notice: "ユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :learning_theme)
  end

  def set_user
    @user = current_user
  end
end
