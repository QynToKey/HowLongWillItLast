class HomeController < ApplicationController
  skip_before_action :require_login, only: [ :index ]

  def index
    # ログインユーザーのみ「総学習時間」「次のマイルストーン」を用意
    if logged_in?
      @total_hours = (current_user.total_learning_minutes / 60.0).round(1)
      @next_threshold = current_user.next_threshold
    end
  end
end
