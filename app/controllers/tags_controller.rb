class TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy]

  def index
    @tags = current_user.tags.order(:name)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.build(tag_params)

    if @tag.save
      redirect_to tags_path, notice: "タグを保存しました"
    else
      flash.now[:alert] = "タグの保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "タグを更新しました"
    else
      flash.now[:alert] = "タグの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, notice: "タグを削除しました"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end
end
