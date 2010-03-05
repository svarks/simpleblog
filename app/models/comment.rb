class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :touch => true
  belongs_to :user
  validates_presence_of :body, :commentable
  validates_presence_of :author_name, :if => Proc.new { |c| c.user.nil? }
  
  default_scope :order => "created_at desc"
  
end
