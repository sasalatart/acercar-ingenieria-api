class ReportMailer < ApplicationMailer
  def report(from_email, to_emails, body, resource_url)
    @body = body
    @resource_url = resource_url

    mail to: to_emails,
         cc: from_email,
         subject: I18n.t(:report),
         template_name: 'template'
  end
end
