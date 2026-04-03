class HomeController < ApplicationController
  skip_before_action :require_login, only: [ :index ]

  def index
    # ログインユーザーの最初の学習テーマを取得して表示する
    if logged_in?
      @theme = current_user.learning_themes.first
    end
  end
end
