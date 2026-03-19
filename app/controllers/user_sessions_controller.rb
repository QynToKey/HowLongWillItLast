class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to new_learning_record_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
