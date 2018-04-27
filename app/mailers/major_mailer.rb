class MajorMailer < ApplicationMailer
  def contact(from_email, to_emails, subject, body)
    @body = body
    mail to: to_emails, cc: from_email, subject: subject, template_name: 'template'
  end
end
