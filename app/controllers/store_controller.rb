class StoreController < ApplicationController

  def index
    @company = Company.first
  end



end
