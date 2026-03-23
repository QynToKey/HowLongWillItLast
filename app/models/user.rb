class User < ApplicationRecord
  authenticates_with_sorcery!

  before_validation { email&.downcase! } # 保存時に正規化

  has_many :learning_records, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :todos, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false } # Email の重複判定で大文字小文字を区別しない
  validates :password, presence: true,
            confirmation: true,
            length: { minimum: 6 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  # 総学習時間のマイルストーンを設定
  THRESHOLDS = [
    { hours: 1000, label: "初級" },
    { hours: 2500, label: "中級" },
    { hours: 5000, label: "上級" },
    { hours: 10000, label: "エキスパート" }
  ].freeze

  # 指定したタグが付いている学習時間の合計を計算する
  def total_learning_minutes_by_tag(tag)
    learning_records.joins(:tags).where(tags: { id: tag.id }).sum(:duration_minutes)
  end

  # 指定した日付の学習時間の合計を計算する
  def total_learning_minutes_by_date(date)
    learning_records.where(study_date: date).sum(:duration_minutes)
  end

  # 総学習時間
  def total_learning_minutes
    learning_records.sum(:duration_minutes)
  end

  # 現在の総学習時間を超える最初の閾値を取得
  def next_threshold
    total_hours = total_learning_minutes / 60.0
    THRESHOLDS.find { |t| t[:hours] > total_hours }
  end
end
