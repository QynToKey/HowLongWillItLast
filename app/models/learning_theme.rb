class LearningTheme < ApplicationRecord
  belongs_to :user

  # 自分自身を除いた他の learning_theme の存在を確認し、存在すれば２つ目以降の name を必須にする
  validates :name, presence: true, if: -> { user.learning_themes.where.not(id: id).exists? }
end
