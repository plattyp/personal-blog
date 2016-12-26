class User < ActiveRecord::Base
  has_many :posts
  has_one :userdetail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :userdetail

  # Creates an attribute that is accessible by the views for Sign Up Code
  attr_accessor :signupcode

  # Validation for signup so that a user must give this SIGNUPCODE for the environment to sign up
  validates :signupcode, inclusion: { in: [Rails.application.secrets.signupcode], message: 'is not correct' }

  # Returns an array of users that can be used for a form selector
  def self.selectusers
    User.all.pluck('name', 'id')
  end

  # Returns a true or false if the user has an associated UserDetail record
  def has_details?
    userdetail != nil
  end
end
