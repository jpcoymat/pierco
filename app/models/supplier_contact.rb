class SupplierContact < ActiveRecord::Base

  validates :supplier_id, :first_name, :last_name, presence: true

  belongs_to :supplier

end
