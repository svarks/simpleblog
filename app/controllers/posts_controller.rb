class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  before_filter :check_ownership, :only => [:edit, :update, :destroy]
  cache_sweeper :post_sweeper, :only => [:create, :update, :destroy]
  
  def index
    @cache_conditions = {:page => params[:page] || 1, :conditions => {}}
    if params[:user_id]
      @user = User.find(params[:user_id])
      @cache_conditions[:conditions].merge!(:user_id => @user.id)
    end
    
    unless read_fragment(@cache_conditions)
      @posts = Post.paginate(@cache_conditions)
    end
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace_html 'posts', :partial => 'list'
        end
      }
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace_html 'comments', :partial => 'comments/list', :locals => {:comments => @page.comments}
        end
      }
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to @post
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to root_url
  end
  
protected
  def find_post
    @post = Post.find(params[:id])
  end

  def check_ownership
    unless @post.user == current_user
      flash[:alert] = "You can only manage your own post."
      redirect_to @post
    end
  end
end
