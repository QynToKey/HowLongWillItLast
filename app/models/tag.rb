class Tag < ApplicationRecord
  belongs_to :user

  has_many :record_tags, dependent: :destroy
  has_many :learning_records, through: :record_tags
  has_many :todo_tags, dependent: :destroy
  has_many :todos, through: :todo_tags
end
