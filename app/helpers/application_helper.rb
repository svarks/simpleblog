# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def textilize(text)
    RedCloth.new(text).to_html
  end
  
  def errors_for(model, field)
    error = case errors = model.errors.on(field)
      when Array then errors.first
      when String then errors
    end
    content_tag :div, error, :class => :error
  end
  
  # outputs tag cloud for posts
  def tag_cloud_for_posts(classes)
    tags = Tag.all(:select => "*, (select COUNT(tag_id) from #{Tagging.table_name} where tag_id=#{Tag.table_name}.id) AS count")
    # tags = Tag.all(:joins => :taggings, :select => "#{Tag.table_name}.*, COUNT(*) AS count", :group => :tag_id)
    return [] if tags.empty?
    max_count = tags.sort_by(&:count).last.count.to_f
    tags.each do |tag|
      index = ((tag.count.to_i / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end
end
