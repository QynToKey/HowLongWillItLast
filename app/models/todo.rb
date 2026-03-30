class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :learning_theme

  has_many :todo_tags, dependent: :destroy
  has_many :tags, through: :todo_tags
end
