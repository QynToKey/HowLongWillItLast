class ChangeUniqueIndexOnTags < ActiveRecord::Migration[8.1]
  def change
    remove_index :tags, [:user_id, :name]
    add_index :tags, [:learning_theme_id, :name], unique: true
  end
end
