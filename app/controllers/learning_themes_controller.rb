class LearningThemesController < ApplicationController
  before_action :set_learning_theme, only: %i[destroy]

  def destroy
    @learning_theme.destroy
    redirect_to user_path(current_user), notice: "学習テーマを削除しました"
  end

  private

  def set_learning_theme
    # current_user の learning_themes の中からのみ検索し、他のユーザーの learning_theme を誤って操作しないようにする
    @learning_theme = current_user.learning_themes.find(params[:id])
  end
end
