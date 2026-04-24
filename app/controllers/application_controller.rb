class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :require_login
  skip_before_action :require_login, only: [ :about, :logs ]
  helper_method :logged_in? # ログイン状態をビューで確認できるようにする
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  def about
  end

  def logs
  end

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end
