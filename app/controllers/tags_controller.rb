class TagsController < ApplicationController
  before_action :set_learning_theme
  before_action :set_tag, only: %i[edit update destroy]

  def index
    @tags = @learning_theme.tags.order(:name)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = @learning_theme.tags.build(tag_params)
    @tag.user = current_user

    if @tag.save
      redirect_to learning_theme_tags_path(@learning_theme), notice: "タグを保存しました"
    else
      flash.now[:alert] = "タグの保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to learning_theme_tags_path(@learning_theme), notice: "タグを更新しました"
    else
      flash.now[:alert] = "タグの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to learning_theme_tags_path(@learning_theme), notice: "タグを削除しました"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  # @learning_theme の tags の中からのみ検索することで、他ユーザーの tag にアクセスできないようにする
  def set_tag
    @tag = @learning_theme.tags.find(params[:id])
  end

  # current_user の learning_themes の中からのみ検索することで、他ユーザーの learning_theme にアクセスできないようにする
  def set_learning_theme
    @learning_theme = current_user.learning_themes.find(params[:learning_theme_id])
  end
end
