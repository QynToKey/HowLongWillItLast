class AddLearningThemeIdToTodos < ActiveRecord::Migration[8.1]
  def change
    add_reference :todos, :learning_theme, null: false, foreign_key: true
  end
end
