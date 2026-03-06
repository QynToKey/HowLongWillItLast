class DropLearningThemes < ActiveRecord::Migration[7.2]
  def change
    drop_table :learning_themes
  end
end
