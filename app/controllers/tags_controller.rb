class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name(params[:id])
    @posts = Post.paginate(:page => params[:page], :per_page => 5, :joins => :taggings, :conditions => {:taggings => {:tag_id => @tag.id}})
    
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace_html 'posts', :partial => 'posts/list'
        end
      }
    end
  end
end