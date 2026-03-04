class CreateLearningThemes < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_themes do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
