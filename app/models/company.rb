class Company < ActiveRecord::Base
  
  include Upload
  
  validates :name, :address_1, :city, :state, :country,:presence => true
  validates :name, :uniqueness => true
  validates :image_filename, :format => {
    :with	=> %r{\.(gif|jpg|png)$}i, :message => 'Imagen debe ser tipo GIF, JPG or PNG.'
  }
  
  
  has_many  :users
  has_many  :suppliers
  has_many  :product_categories
  has_many  :distributors
  
  def full_address
    self.address_2.nil? ? self.address_1 : self.address_1 + "\n" + self.address_2
  end


  def products
    @products = []
    self.suppliers.each do |supplier|
      @products << supplier.products
    end
    @products.flatten!
    @products
  end
  
  def product_subcategories
    @product_subcategories = []
    self.product_categories.each do |pc|
      @product_subcategories << pc.product_subcategories
    end
    @product_subcategories.flatten!
    @product_subcategories
  end
  
  def active_products
    @active_products = products
    @active_products.delete_if {|product| !(product.active)}
    @active_products  
  end
  
  def city_country
    self.city + ", " + self.country
  end
  
  def telephones
    telephones = ""
    attributes.each do |k,v|
      if k.to_s.include?("telephone_") and !(v.blank?)
        telephones += v.to_s + " "
      end
    end
    telephones      
  end
  
  def distributor_by_city(city)
    Distributor.where(:company_id => self.id, :city => city).all
  end
  
  def distributor_cities
    @distributor_cities = []
    self.distributors.each do |distributor|
      @distributor_cities << distributor.city unless @distributor_cities.include?(distributor.city)
    end
    @distributor_cities
  end
  
  

end
