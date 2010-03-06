class User < ActiveRecord::Base
  validates_presence_of   :username
  validates_uniqueness_of :username
  devise :registerable, :authenticatable, :recoverable, :rememberable, :trackable, :validatable
  # , :confirmable
  
  has_many :posts
  has_many :comments
  
  attr_accessor :username_or_email
  
private
  def self.find_for_authentication(conditions)
    uoe = conditions[:username_or_email]
    first(:conditions => ["username=? or email=?", uoe, uoe])
  end
end
