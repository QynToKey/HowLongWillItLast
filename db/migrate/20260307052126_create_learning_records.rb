class CreateLearningRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :study_date, null: false
      t.integer :duration_minutes
      t.text :content, null: false
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
