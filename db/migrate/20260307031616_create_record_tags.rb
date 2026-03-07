class CreateRecordTags < ActiveRecord::Migration[7.2]
  def change
    create_table :record_tags do |t|
      t.references :learning_record, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :record_tags, [:learning_record_id, :tag_id], unique: true
  end
end
