class AdminController < ApplicationController

  before_filter :authorize

  def index
    @user = User.find(session[:user_id])
  end

  def companies
    @company = User.find(session[:user_id]).company
  end
  
  def new_company
    @company = Company.new
  end
  
  def create_company
    @company = Company.new(params[:company])
    if @company.save
      flash[:notice] = "Compa&ntilde;ia creada exitosamente"
      redirect_to :controller => 'admin', :action => 'companies'
    else
      flash[:notice] = "Error creando Compa&ntilde;ia ".html_safe
      redirect_to :controller => 'admin', :action => 'new_company'
    end
  end
  
  def edit_company
    @company = Company.find(params[:company])
  end
  
  def update_company
    @company = Company.find(params[:company][:id])
    picture_file = params[:company][:logo_picture] if !(params[:company][:logo_picture].nil?)
    params[:company].delete("logo_picture")
    if @company.update_attributes(params[:company])
      if picture_file
        @company.set_picture_file(picture_file)
      end
      flash[:notice] = "Compa&ntilde;ia actualizada exitosamente".html_safe
      redirect_to :controller => 'admin', :action => 'companies'
    else
      flash[:notice] = "Error actualizad Compa&ntilde;ia ".html_safe
      redirect_to :controller => 'admin', :action => 'edit_company', :company => @company
    end
  end
  
  def delete_company
    
  end
  

  def products
    @suppliers = User.find(session[:user_id]).company.suppliers
    @product_categories = User.find(session[:user_id]).company.product_categories
    @product_subcategories = User.find(session[:user_id]).company.product_subcategories
    @products = User.find(session[:user_id]).company.products
    if request.post?
      product_search = params[:product_search].clone
      product_search.delete_if {|k,v| v.blank? }
      @products = Product.where(product_search).order('name ASC').all
    end
  end
  
  def view_product
    @product = Product.find(params[:product])
  end
  
  def new_product
    @product = Product.new
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
  end
  
  def create_product
    picture_file = params[:product][:image_file]
    params[:product].delete("image_file")
    @product = Product.new(params[:product])
    @product.set_picture_file(picture_file) if picture_file  
    if @product.save        
      flash[:notice] = "Producto creado exitosamnte"
      redirect_to :controller=> 'admin', :action => 'view_product', :product => @product
    else
      flash[:notice] = "Error creando producto"
      render :action => 'new_product'
    end
  end
  
  def edit_product
    @product = Product.find(params[:product])
    @company = User.find(session[:user_id]).company
    @suppliers = @company.suppliers
    @product_categories = @company.product_categories
    @product_subcategories = @company.product_subcategories
  end
  
  def update_product
    picture_file = params[:product][:image_file]
    params[:product].delete("image_file")
    @product = Product.find(params[:product][:id])
    if @product.update_attributes(params[:product])
      @product.set_picture_file(picture_file) if picture_file          
      flash[:notice] = "Producto actualizado exitosamente"
      redirect_to :controller => 'admin', :action => 'view_product',:product => @product
    else
      flash[:notice] = "Error actualizando producto"
      render :action => 'edit_product'    
    end
  end
  
  def delete_product
    Product.destroy(params[:product])
    flash[:notice] ="Producto eliminado exitosamente"
    redirect_to :controller => 'admin', :action => 'products'
  end
  
  def product_categories
    @product_categories = User.find(session[:user_id]).company.product_categories
  end
  
  def new_product_category
    @company = User.find(session[:user_id]).company
    @product_category = ProductCategory.new
  end
  
  def create_product_category
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      flash[:notice] = "Categoria creada exitosamente"
      redirect_to :controller => 'admin', :action => 'product_categories'
    else
      flash[:notice] = "Error creando categoria"
      render :action => 'new_product_category'
    end
  end
  
  def edit_product_category
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def update_product_category
    @product_category = ProductCategory.find(params[:product_category][:id])
    if @product_category.update_attributes(params[:product_category])
      flash[:notice] = "Categoria actalizada exitosamente"
      redirect_to :controller => 'admin', :action => 'product_categories'
    else
      flash[:notice] = "Error actualizando categoria"
      render :action => 'edit_product_category'      
    end
  end
  
  def delete_product_category
    ProductCategory.destroy(params[:product_category])
    flash[:notice] = "Catgoria eliminada exitosamente"
    redirect_to :controller => 'admin', :action => 'product_categories'
  end
  

  def product_subcategories
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def new_product_subcategory
    @product_category = ProductCategory.find(params[:product_category])
  end
  
  def create_product_subcategory
    @product_subcategory = ProductSubcategory.new(params[:product_subcategory])
    if @product_subcategory.save
      flash[:notice] = "Subcategoria creada exitosamente"
    else
      flash[:notice] = "Error creand subcategoria"
    end
    redirect_to :controller => 'admin', :action => 'product_subcategories', :product_category => @product_subcategory.product_category
  end
  
  def edit_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory])
  end
  
  def update_product_subcategory
    @product_subcategory = ProductSubcategory.find(params[:product_subcategory][:id])
    if @product_subcategory.update_attributes(params[:product_subcategory])
      flash[:notice] = "Subcategoria actualizada exitosamente"
      redirect_to :controller=> 'admin', :action => 'product_subcategories', :product_category => @product_subcategory.product_category
    else
      flash[:notice] = "Error actualizando subcategoria"
      render :action => 'edit_product_subcategory'
    end
  end
  
  def delete_product_subcategory
    ProductSubcategory.destroy(params[:product_subcategory])
    flash[:notice] = "Subcategoria eliminada exitosamente"
    redirect_to :controller=> 'admin', :action => 'product_subcategories'
  end


  def distributors
    @distributors = User.find(session[:user_id]).company.distributors
  end
  
  def new_distributor
    @company = User.find(session[:user_id]).company
    @distributor = Distributor.new
  end
  
  def view_distributor
    @distributor = Distributor.find(params[:distributor])
  end
  
  
  def create_distributor
    @distributor = Distributor.new(params[:distributor])
    if @distributor.save
      flash[:notice] = "Distrtibuidor creado exitosamente"
      redirect_to :controller => 'admin', :action => 'distributors'
    else
      flash[:notice] = "Error creando distribuidor"
      render :action => 'new_distributor'
    end
  end
  
  def edit_distributor
    @distributor = Distributor.find(params[:distributor])
  end
  
  def update_distributor
    @distributor = Distributor.find(params[:distributor][:id])
    if @distributor.update_attributes(params[:distributor])
      flash[:notice] = "Distribuidor actualizado exitosamente"
      redirect_to :controller => 'admin', :action => 'distributors'
    else
      flash[:notice] = "Error actualizando distribuidor"
      render :action => 'edit_distributor'
    end
  end
  
  def delete_distributor
    Distributor.destroy(params[:distributor])
    flash[:notice] = "Distribuidor eliminado exitosamente"
    redirect_to :controller => 'admin', :action => 'distributors'
  end


  def users
    @users = User.find(session[:user_id]).company.users
  end
  
  def new_user
    @user = User.new
  end
  
  def create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuario creado exitosamente"
      redirect_to :controller => 'admin', :action => 'users'
    else
      flash[:notice] = "Error creando usuario"
      redirect_to :controller => 'admin', :action => 'new_user'
    end
  end
  
  def edit_user
    @user = User.find(params[:user])
  end
  
  def update_user
    @user= User.find([:user][:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuario actualizado exitosamente"
      redirect_to :controller => 'admin', :action => 'users'
    else
      flash[:notice] = "Error actualizando usuario"
      redirect_to :controller => 'admin', :action => 'edit_user', :user => @user
    end
  end
  
  def delete_user
    User.destroy(params[:user])
    flash[:notice] = "Usuario eliminado"
    redirect_to :controller => 'admin', :action=> 'users'
  end
  
  
  def suppliers
    @suppliers = User.find(session[:user_id]).company.suppliers
  end
  
  def view_supplier
    @supplier = Supplier.find(params[:supplier])
  end

  def new_supplier
    @supplier = Supplier.new
  end
  
  def create_supplier
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    params[:supplier].delete("logo_picture")
    @supplier = Supplier.new(params[:supplier])
    @supplier.set_picture_file(picture_file) if picture_file
    if @supplier.save
      flash[:notice] = "Marca creada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_supplier',:supplier => @supplier
    else
      flash[:notice] = "Error crendo nueva marca"
      render :action => 'new_supplier'
    end
  end
  
  def edit_supplier
    @supplier = Supplier.find(params[:supplier])
  end

  def update_supplier
    picture_file = params[:supplier][:logo_picture] if !(params[:supplier][:logo_picture].nil?)
    @supplier = Supplier.find(params[:supplier][:id])
    params[:supplier].delete("logo_picture")
    if @supplier.update_attributes(params[:supplier])
      @supplier.set_picture_file(picture_file) if picture_file
      flash[:notice] = "Marca actualizada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_supplier', :supplier => @supplier
    else
      flash[:notice] = "Error actualizand Marca"
      render :action => 'edit_supplier'
    end
  end
  
  def delete_supplier
    Supplier.destroy(params[:supplier])
    flash[:notice] = "Marca eliminada exitosamente"
    redirect_to :controller => 'admin', :action => 'suppliers'
  end
  
  def new_product_dimension
    @product = Product.find(params[:product])
  end

  def create_product_dimension
    @product_dimension = ProductDimension.new(params[:product_dimension])
    if @product_dimension.save
      flash[:notice] = "Dimension creada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_product', :product=> @product_dimension.product
    else
      flash[:notice] = "Error creando dimension de producto"
      render :action => 'new_product_dimension'
    end
  end
  
  def edit_product_dimension
    @product_dimension = ProductDimension.find(params[:product_dimension])
    @product = @product_dimension.product
  end
  
  def update_product_dimension
    @product_dimension = ProductDimension.find(params[:product_dimension][:id])
    if @product_dimension.update_attributes(params[:product_dimension])
      flash[:notice] = "Dimension actualizada exitosamente"
      redirect_to :controller => 'admin', :action => 'view_product', :product => @product_dimension.product
    else
      flash[:notice] = "Error actualizando dimension"
      render :action => 'edit_product_dimension'
    end
  end
  
  def delete_product_dimension
    @product = Product.find(params[:product_dimension][:product_id])
    ProductDimension.destroy(params[:product_dimension])
    flash[:notice] = "Dimension eliminada exitosamente"
    redirect_to :controller => 'admin', :action => 'view_product', :product => @product
  end
  

end
