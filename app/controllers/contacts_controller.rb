class ContactsController < ApplicationController

  skip_before_action :authorize

  def create
    @company = Company.first
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        Notifier.customer_feedback_received(@contact).deliver
        format.html {redirect_to thank_you_path}
        format.js
      else      
        format.html {render :action => 'contact_us'}
        format.js
      end
    end
  end
  
  private 

  def contact_params
    params.require(:contact).permit(:company_id, :message, :email, :name)	
  end
end
