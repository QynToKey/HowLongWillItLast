class RemoveUserIdFromLearningRecordsTagsTodos < ActiveRecord::Migration[8.1]
  def change
    remove_index :learning_records, :user_id
    remove_index :tags, :user_id
    remove_index :todos, :user_id

    remove_column :learning_records, :user_id
    remove_column :tags, :user_id
    remove_column :todos, :user_id
  end
end
