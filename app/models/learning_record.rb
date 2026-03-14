class LearningRecord < ApplicationRecord
  belongs_to :user

  # バリデーションの前に学習時間を計算するコールバック
  before_validation :calculate_duration

  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :study_date, presence: true
  validates :content, presence: true
  validates :duration_minutes, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }

end
