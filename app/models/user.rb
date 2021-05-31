class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/ }
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/ } do
      validates :last_name
      validates :family_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :kana_last_name
      validates :kana_family_name
    end
    validates :birth_day
  end
end
