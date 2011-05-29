class Distributor < ActiveRecord::Base

  validates   :company_id, :name, :address_1, :city, :country, :presence => {:message => "Nombre, Ciudad, Direccion no pueden estar en blanco"}
  validates   :name,  :uniqueness => {:message => "Nombre ya existe"}
  
  belongs_to  :company


  def full_address
    self.address_1 + "\n" + self.address_2
  end


  def telephones
    telephones = ""
    attributes.each do |k,v|
      if k.to_s.include?("telephone_") and !(v.blank?)
        telephones += v.to_s + " - "
      end
    end
    telephones.chop!
    telephones.chop!
    telephones      
  end


end
