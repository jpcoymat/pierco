require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "customer_feedback_received" do
    mail = Notifier.customer_feedback_received
    assert_equal "Customer feedback received", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
