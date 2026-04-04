class HomeController < ApplicationController
  skip_before_action :require_login, only: [ :index ]

  def index
    # トップページでは、ログインユーザーの学習テーマとその学習時間を表示するためにデータを準備する
    if logged_in?
      @learning_themes = current_user.learning_themes
    end
  end
end
