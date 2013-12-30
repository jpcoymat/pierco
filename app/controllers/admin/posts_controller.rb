class PostsController < ApplicationController

  before_filter :authorize

  def index
    @company = User.find(session[:user_id]).company
    @posts = @company.posts
  end
  
  def new
    @company = User.find(session[:user_id]).company
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Noticia creada"
      redirect_to admin_posts_path
    else
      flash[:notice] = "Error creando noticia"
      redirect_to admin_posts_path
    end
  end
  
  def edit
    @post = Post.find(params[:post])
  end
  
  def update
    @post = Post.find(params[:post][:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Noticia actualizada exitosamente"
      redirect_to admin_posts_path
    else
      flash[:notice] = "Error actualizando noticia"
      render action: 'edit'
    end
  end
  
  def destroy
    Post.destroy(params[:post])
    redirect_to admin_posts_path
  end  


end