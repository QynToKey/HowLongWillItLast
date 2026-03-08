class LearningRecord < ApplicationRecord
  belongs_to :user

  # バリデーションの前に学習時間を計算するコールバック
  before_validation :calculate_duration

  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :study_date, presence: true
  validates :content, presence: true
  validates :duration_minutes, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :started_at, allow_nil: true
  validates :ended_at, allow_nil: true
  # 開始時間と終了時間の両方が存在する場合、終了時間は開始時間より後でなければならない
  validate :ended_at_after_started_at

  private

  # 開始時間と終了時間から学習時間を計算して duration_minutes にセットする
  def calculate_duration
    if started_at.present? && ended_at.present?
      self.duration_minutes = ((ended_at - started_at) / 60).to_i
    end
  end

  # 終了時間は開始時間より後でなければならない
  def ended_at_after_started_at
    return if started_at.blank? || ended_at.blank?

    if ended_at <= started_at
      errors.add(:ended_at, "は開始時間より後の時刻を入力してください")
    end
  end
end
