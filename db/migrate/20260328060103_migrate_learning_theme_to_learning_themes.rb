class MigrateLearningThemeToLearningThemes < ActiveRecord::Migration[8.1]
  def up
    # 全ユーザーに learning_themes レコードを１件作成
    User.find_each do |user|
      LearningTheme.create!(
        user_id: user.id,
        name: user.learning_theme #nil でもそのまま learning_themes.name へコピー
      )
    end

    # users.learning_theme カラムを削除
    remove_column :users, :learning_theme
  end

  # db:rollback が必要になったときは up メソッドを逆再生する
  def down
    add_column :users, :learning_theme, :string

    LearningTheme.find_each do |theme|
      User.find(theme.user_id).update!(learning_theme: theme.name)
    end
  end
end
