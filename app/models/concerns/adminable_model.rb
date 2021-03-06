module AdminableModel
  def promote_to_admin(major_id = nil)
    major_id ? add_role(:major_admin, Major.find(major_id)) : add_role(:admin)
    self
  end

  def demote_from_admin(major_id = nil)
    major_id ? remove_role(:major_admin, Major.find(major_id)) : remove_role(:admin)
    self
  end

  def admin?(major_id = nil)
    has_role?(:admin) || Major.ids_where_is_admin(self).include?(major_id.to_i)
  end

  def admin_of_something?
    has_role?(:admin) || Major.with_role(:major_admin, self).size.nonzero?
  end
end
