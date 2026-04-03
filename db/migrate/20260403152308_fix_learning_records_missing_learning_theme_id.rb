class FixLearningRecordsMissingLearningThemeId < ActiveRecord::Migration[8.1]
  def up
    LearningRecord.where(learning_theme_id: nil).find_each do |record|
      theme = LearningTheme.find_by(user_id: record.user_id)
      record.update_columns(learning_theme_id: theme.id) if theme
    end
  end

  def down
    # 不可逆なマイグレーションのため rollback は行わない
  end
end
