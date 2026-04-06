class LearningRecord < ApplicationRecord
  belongs_to :learning_theme, optional: true # nil 許容

  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :study_date, presence: true
  validates :content, presence: true
  validates :duration_minutes, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
end
