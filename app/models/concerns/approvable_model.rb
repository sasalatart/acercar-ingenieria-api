module ApprovableModel
  def update_approval(value, user)
    update_attribute(:approved, value)
    notify_approval_changed(value, user)

    return unless respond_to?(:comments)
    Comment.where(commentable: [self, comments])
           .update_all(approved_commentable: value)
  end

  def notify_approval_changed(value, user)
    type = NotifyableModel::NOTIFICATION_TYPES[value ? :approved : :rejected]
    user_ids = User.with_role(:admin).pluck(:id)
    user_ids += major.admins.pluck(:id) if respond_to?(:major_id) && major_id
    user_ids += [author_id] if respond_to?(:author_id)
    notify(type, user.id, user_ids)
  end
end
