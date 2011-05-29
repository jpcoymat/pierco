class Supplier < ActiveRecord::Base
  
  include Upload
  
  validates_presence_of :name, :address_1, :city, :country, :company_id, :presence => {:message => "no pueden estar en blanco"}
  validates :name, :uniqueness => {:message => "ya existe"}
  
  validates :image_filename, :format => {
    :with	=> %r{\.(gif|jpg|png)$}i, :message => 'Imagen debe ser de tipo GIF, JPG or PNG.'
  }
  
  belongs_to :company
  
  has_many :products
  has_many :supplier_contacts
  
  
  def full_address
    self.address_2.nil? ? self.address_1 : self.address_1 + "\n" + self.address_2
  end
  
  def deleteable?
    self.products.empty?
  end
  
end
