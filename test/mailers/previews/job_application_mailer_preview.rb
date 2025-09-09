# Preview all emails at http://localhost:3000/rails/mailers/job_application_mailer
class JobApplicationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/job_application_mailer/created_email
  def created_email
    JobApplicationMailer.created_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/job_application_mailer/status_changed_email
  def status_changed_email
    JobApplicationMailer.status_changed_email
  end

end
