class AddLearningThemeToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :learning_theme, :string
  end
end
