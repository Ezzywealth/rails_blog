class CommentsController < ApplicationController
  before_action :set_user, only: %i[index show]
  before_action :set_post, only: %i[index show new create edit update destroy]

  def new
  end

  def index
    @comments = @post.comments.paginate(page: params[:page], per_page: 2)
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def create
    body = params[:body]
    @comment = Comment.new(body: body, post: @post, author: current_user)
    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = "Comment couldn't be created"
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end