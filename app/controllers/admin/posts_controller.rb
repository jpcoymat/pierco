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
      redirect_to :controller => 'admin', :action => 'posts'
    else
      flash[:notice] = "Error creando noticia"
      redirect_to :controller => 'amdin', :action => 'new_post'
    end
  end
  
  def edit
    @post = Post.find(params[:post])
  end
  
  def update
    @post = Post.find(params[:post][:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Noticia actualizada exitosamente"
      redirect_to :controller => 'admin', :action => 'posts'
    else
      flash[:notice] = "Error actualizando noticia"
      redirec_to :controller => 'admin', :action => 'edit_post', :post => @post
    end
  end
  
  def destroy
    Post.destroy(params[:post])
    redirect_to :controller => 'admin', :action => 'posts'
  end  


end
