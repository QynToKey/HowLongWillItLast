class LearningThemesController < ApplicationController
  def new
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def learning_theme_params
    params.require(:learning_theme).permit(:name, :description)
  end
end
