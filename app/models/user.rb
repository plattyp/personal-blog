class User < ActiveRecord::Base
  has_many :posts
  has_one :userdetail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :userdetail

  attr_accessor :signupcode

  validates :signupcode, inclusion: {in: [ENV['SIGNUPCODE']], :message => "is not correct"}

  def has_details?
  	self.userdetail != nil
  end

end
