module Adminable
  def toggle_admin(major_id = nil)
    unless major_id
      has_role?(:admin) ? remove_role(:admin) : add_role(:admin)
      return self
    end

    @major = Major.find(major_id)
    admin = has_role?(:major_admin, @major)
    admin ? remove_role(:major_admin, @major) : add_role(:major_admin, @major)
    self
  end

  def admin_of_something?
    has_role?(:admin) || Major.with_role(:major_admin, self).size.nonzero?
  end
end
