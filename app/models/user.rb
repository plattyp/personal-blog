class User < ActiveRecord::Base
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :signupcode

  validates :signupcode, inclusion: {in: [ENV['SIGNUPCODE']], :message => "is not correct"}
end
