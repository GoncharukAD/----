class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[edit update show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_post_not_found

  def index
    @posts = Post.all
  end

  def edit; end

  def show; end

  def update
    @post.update ? (redirect_to @post, notice: t('.success_update')) : (render :edit)
  end

  def destroy
    @posts.destroy
    redirect_to posts_path, notice: t('.success_delete')
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: t('.success_create')
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
