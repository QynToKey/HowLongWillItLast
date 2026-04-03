class LearningTheme < ApplicationRecord
  belongs_to :user

  # 自分自身を除いた他の learning_theme の存在を確認し、存在すれば２つ目以降の name を必須にする
  validates :name, presence: true, if: -> { user.learning_themes.where.not(id: id).exists? }
  validate :within_theme_limit

  has_many :learning_records, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :todos, dependent: :destroy

  # 総学習時間
  def total_learning_minutes
    learning_records.sum(:duration_minutes)
  end

  # 現在の総学習時間を超える最初の閾値を取得
  def next_threshold
    total_hours = total_learning_minutes / 60.0
    User::THRESHOLDS.find { |t| t[:hours] > total_hours }
  end

  # 総学習時間を時間単位で取得（小数点1位まで）
  def total_learning_minutes_in_hours
    (total_learning_minutes / 60.0).round(1)
  end

  private

  def within_theme_limit
    return unless user
    # 新規作成時のみチェック（編集時はスキップ）
    if new_record? && user.learning_themes.count >= 3
      errors.add(:base, "学習テーマは３件までしか登録できません")
    end
  end
end
