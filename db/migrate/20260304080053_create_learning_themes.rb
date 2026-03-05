class CreateLearningThemes < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_themes do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :learning_themes, [ :user_id, :name ], unique: true
  end
end
