class User < ApplicationRecord
  has_many :results

  validates :display_name, presence: true, uniqueness: true, format: { without: /\s/ }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
