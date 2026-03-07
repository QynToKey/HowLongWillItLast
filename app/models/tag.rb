class Tag < ApplicationRecord
  belongs_to :user

  has_many :record_tags, dependent: :destroy
  has_many :learning_records, through: :record_tags
end
