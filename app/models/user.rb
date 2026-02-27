class User < ApplicationRecord
  authenticates_with_sorcery!

  before_validation { email&.downcase! } # 保存時に正規化
  
  validates :email,
            presence: true,
            uniqueness: true
  validates :password,
            presence:true,
            confirmation: true,
            length: { minimum: 6 },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }
end
