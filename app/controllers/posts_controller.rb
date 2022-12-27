class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_post_not_found

  def index
    @posts = Post.all
  end

  def edit; end

  def update
    @post.update ? (redirect_to @post) : (render :edit)
  end

  def destroy
    @posts.destroy
    redirect_to posts_path
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.build(post_params)
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end


  def rescue_with_post_not_found
    render plain: t('.not_found')
  end
end
