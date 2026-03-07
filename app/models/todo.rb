class Todo < ApplicationRecord
  belongs_to :user

  has_many :todo_tags, dependent: :destroy
  has_many :tags, through: :todo_tags
end
