class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, dependent: :destroy

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :last_name, :created_at]
    ]
  end

  def to_s
  	"#{first_name} #{last_name}"
  end
end
