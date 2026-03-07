class LearningRecord < ApplicationRecord
  belongs_to :user

  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags
end
