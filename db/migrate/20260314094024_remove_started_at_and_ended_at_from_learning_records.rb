class RemoveStartedAtAndEndedAtFromLearningRecords < ActiveRecord::Migration[7.2]
  def change
    remove_column :learning_records, :started_at, :datetime
    remove_column :learning_records, :ended_at, :datetime
  end
end
