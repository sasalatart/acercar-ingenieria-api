module Sanitizable
  def sanitize(*properties)
    properties.each do |attr|
      next unless self[attr]
      self[attr] = Sanitize.fragment(self[attr], Sanitize::Config::RELAXED)
    end
  end
end
