class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :vocabs
  has_attached_file :image, styles: {
    medium: "300x300>",
    thumb: "100x100>"
  }
  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
