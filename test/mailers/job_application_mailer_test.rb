require "test_helper"

class JobApplicationMailerTest < ActionMailer::TestCase
  test "created_email" do
    mail = JobApplicationMailer.created_email
    assert_equal "Created email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "status_changed_email" do
    mail = JobApplicationMailer.status_changed_email
    assert_equal "Status changed email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
