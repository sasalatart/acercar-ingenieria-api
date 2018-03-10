class MajorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.major_mailer.broadcast.subject
  #
  def broadcast(major, subject, content)
    emails = major.users.pluck(:email).join(',')
    @content = content

    mail to: emails, subject: subject
  end
end
