class User < ActiveRecord::Base
  has_one :user_profile, dependent: :destroy
  has_one :user_preference, dependent: :destroy
  has_many :user_match, dependent: :destroy
  has_many :user_picture, dependent: :destroy
  has_many :user_message, dependent: :destroy
  has_many :user_rating, dependent: :destroy
  has_many :user_blacklist, dependent: :destroy
  has_many :flagged_user, dependent: :destroy
  
  validates :user_type_id, presence: true, inclusion: 1..2
  validates :password_confirmation, presence: true
  validates_format_of :email,:with => Devise.email_regexp
  validates_confirmation_of :password
  #validates :user_profile, presence: true 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
  :registerable,
  :recoverable,
  :rememberable,
  :trackable,
  :validatable

  #attr_accessible :name, :email, :authentication_token

  before_save :ensure_authentication_token!
  
  def set_anonymous_user
    self.authentication_token = generate_authentication_token
    self.email = "#{self.authentication_token}@email.com"
  end
  def ensure_authentication_token!
    self.authentication_token ||= generate_authentication_token
  end

  def reset_authentication_token!
    # exclude anonymous users 
    self.update_attribute(:authentication_token, generate_authentication_token) if self.user_type_id != 1
  end

  def is_anonymous?
    self.user_type_id == 1 
  end
  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
