class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :taggings, :as => :taggable, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  default_scope :order => "created_at desc"
  
  validates_presence_of :title, :body
  after_save :assign_tags
  
  def self.per_page
    5
  end
  
  def formatted_body
    markdown = RDiscount.new(body, :smart, :filter_html)
    markdown.to_html
  end
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z1-9]+/i, '-')}"
  end
  
  attr_writer :tag_list
  def tag_list
    @tag_list || tags.map(&:name).join(', ')
  end
  
private
  
  def assign_tags
    if @tag_list
      self.tags = @tag_list.split(/,\s*/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
  
end
