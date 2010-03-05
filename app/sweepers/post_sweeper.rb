class PostSweeper < ActionController::Caching::Sweeper
  observe Post, Tagging
  
  def after_save(model)
    expire_cache(model)
  end

  def after_destroy(model)
    expire_cache(model)
  end

  def expire_cache(model)
    case model.class
    when Tagging then
      expire_fragment 'tag_cloud'
    when Post then
      expire_fragment :controller => :posts, :action => :index
    end
  end
end