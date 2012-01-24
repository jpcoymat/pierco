class Distributor < ActiveRecord::Base

  validates   :company_id, :name, :address_1, :city, :country, :presence => {:message => "Nombre, Ciudad, Direccion no pueden estar en blanco"}
  validates   :name,  :uniqueness => {:message => "Nombre ya existe"}
  
  belongs_to  :company


  def full_address
    self.address_2.nil? ? self.address_1 : self.address_1 + "\n" + self.address_2
  end


  def telephones
    telephones = ""
    attributes.each do |k,v|
      if k.to_s.include?("telephone_") and !(v.blank?)
        telephones += v.to_s + " - "
      end
    end
    2.times {telephones.chop!}
    telephones      
  end
  
  def geolocation
    @geolocation = nil
    if self.latitude.nil? or self.longitude.nil?
      @geolocation = self.address_1.sub(" ","+") + "," + self.city + "," + self.country
    else
      @geolocation = self.latitude.to_s + "," + self.longitude.to_s
    end
    @geolocation
  end


end
