class AddLearningThemeIdToLearningRecordsAndTags < ActiveRecord::Migration[8.1]
  def up
    # learning_records に learning_theme_id を追加
    add_reference :learning_records, :learning_theme, foreign_key: true

    # 既存の learning_records を user の最初の learning_theme に紐付け
    LearningRecord.find_each do |record|
      theme = LearningTheme.find_by(user_id: record.user_id)
      record.update_columns(learning_theme_id: theme.id) if theme
    end

    # tags に learning_theme_id を追加
    add_reference :tags, :learning_theme, foreign_key: true

    # 既存の tags を user の最初の learning_theme に紐付け
    Tag.find_each do |tag|
      theme = LearningTheme.find_by(user_id: tag.user_id)
      tag.update_columns(learning_theme_id: theme.id) if theme
    end
  end

  def down
    remove_reference :learning_records, :learning_theme
    remove_reference :tags, :learning_theme
  end
end
