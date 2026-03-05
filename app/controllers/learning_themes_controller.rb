class LearningThemesController < ApplicationController
  before_action :require_login
  before_action :set_learning_theme, only: %i[edit update destroy]

  def new
    @learning_theme = current_user.learning_themes.build
  end

  def create
    @learning_theme = current_user.learning_themes.build(learning_theme_params)

    if @learning_theme.save
      redirect_to learning_themes_path, notice: "テーマを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @learning_themes = current_user.learning_themes.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @learning_theme.update(learning_theme_params)
      redirect_to learning_themes_path, notice: "テーマを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @learning_theme.destroy
    redirect_to learning_themes_path, notice: "テーマを削除しました"
  end

  private
  def learning_theme_params
    params.require(:learning_theme).permit(:name, :description)
  end

  def set_learning_theme
    @learning_theme = current_user.learning_themes.find(params[:id])
  end
end
