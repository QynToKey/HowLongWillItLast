class LearningTheme < ApplicationRecord
  belongs_to :user

  # 自分自身を除いた他の learning_theme の存在を確認し、存在すれば２つ目以降の name を必須にする
  validates :name, presence: true, if: -> { user.learning_themes.where.not(id: id).exists? }
  validate :within_theme_limit

  has_many :learning_records, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :todos, dependent: :destroy

  private

  def within_theme_limit
    return unless user
    # 新規作成時のみチェック（編集時はスキップ）
    if new_record? && user.learning_themes.count >= 3
      errors.add(:base, "学習テーマは３件までしか登録できません")
    end
  end
end
