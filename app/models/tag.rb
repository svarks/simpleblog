class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  
  def to_param
    name
  end
  
  def to_s
    name
  end
end
