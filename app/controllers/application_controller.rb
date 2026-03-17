class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :logged_in? # ログイン状態をビューで確認できるようにする
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end
