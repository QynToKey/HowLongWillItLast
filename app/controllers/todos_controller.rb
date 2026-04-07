class TodosController < ApplicationController
  before_action :set_learning_theme
  before_action :set_todo, only: %i[edit update destroy]

  def index
    @todos = @learning_theme.todos.order(created_at: :desc)
  end

  def new
    @todo = @learning_theme.todos.build
  end

  def create
    @todo = @learning_theme.todos.build(todo_params)

    if @todo.save
      redirect_to learning_theme_todos_path(@learning_theme), notice: "Todoを保存しました"
    else
      flash.now[:alert] = "Todoの保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to learning_theme_todos_path(@learning_theme), notice: "Todoを更新しました"
    else
      flash.now[:alert] = "Todoの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to learning_theme_todos_path(@learning_theme), notice: "Todoを削除しました"
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :is_completed)
  end

  def set_learning_theme
    # current_user の learning_themes の中からのみ検索することで、他ユーザーの learning_theme にアクセスできないようにする
    @learning_theme = current_user.learning_themes.find(params[:learning_theme_id])
  end

  def set_todo
    # @learning_theme の todos の中からのみ検索することで、他ユーザーの todo にアクセスできないようにする
    @todo = @learning_theme.todos.find(params[:id])
  end
end
