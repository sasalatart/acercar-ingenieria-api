module ReportableModel
  def report(from_email, reason, resource_url)
    to_emails = User.with_role(:admin).pluck(:email)
    to_emails += major.admins.pluck(:email) if respond_to?(:major) && major
    to_emails -= [from_email]

    sanitized_reason = Sanitize.fragment(reason, Sanitize::Config::RELAXED)

    ReportMailer.report(
      from_email, to_emails, sanitized_reason, resource_url
    ).deliver
  end
end
