class Notifier < ActionMailer::Base
  default :from => "pierco@pierco.com.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.customer_feedback_received.subject
  #
  def customer_feedback_received(contact)
    @contact = contact
    @greeting = "Hi"
    
    mail(:to => "Pierco Ltda <pierco@pierco.com.co>", :subject => "Feedback Received")
  end
end
