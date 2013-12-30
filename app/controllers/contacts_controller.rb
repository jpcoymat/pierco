class ContactsController < ApplicationController
  def create
    @company = Company.first
    @contact = Contact.new(contact_params)
    if @contact.save
      Notifier.customer_feedback_received(@contact).deliver
      redirect_to thank_you_path
    else      
      render :action => 'contact_us'
    end
  end
  
  private 

  def contact_params
    params.require(:contact).permit(:company_id, :message, :email, :name)	
  end
end
