class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  before_filter :find_post, :only => :create
  before_filter :find_comment, :only => [:edit, :update, :destroy]
  before_filter :check_ownership, :only => [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user if user_signed_in?
    @comment.commentable = @post
    @comment.save
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
  
  def edit
  end
  
  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to @comment.commentable
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to @comment.commentable
  end
  
  
protected
  def check_ownership
    unless @comment.user == current_user
      flash[:alert] = "You can only manage your comments."
      redirect_to @comment.commentable
    end
  end
  
  def find_post
    @post = Post.find(params[:post_id])
  end
  
  def find_comment
    @comment = Comment.find(params[:id])
  end
end
