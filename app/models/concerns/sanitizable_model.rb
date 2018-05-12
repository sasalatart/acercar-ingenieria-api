module SanitizableModel
  def sanitize(*properties)
    properties.each do |attr|
      next unless self[attr] && will_save_change_to_attribute?(attr.to_sym)
      self[attr] = Sanitize.fragment(self[attr], Sanitize::Config::RELAXED)
    end
  end
end
