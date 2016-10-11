class SupplierContact < ApplicationRecord

  validates :supplier_id, :first_name, :last_name, presence: true

  belongs_to :supplier

end
