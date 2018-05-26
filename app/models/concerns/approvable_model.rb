module ApprovableModel
  extend ActiveSupport::Concern

  included do
    after_save :verify_comments_approval
  end

  def update_approval(value, user)
    update!(approved: value)
    notify_approval_changed(value, user)
  end

  private

  def notify_approval_changed(value, user)
    type = NotifyableModel::NOTIFICATION_TYPES[value ? :approved : :rejected]
    user_ids = User.with_role(:admin).pluck(:id)
    user_ids += major.admins.pluck(:id) if respond_to?(:major_id) && major_id
    user_ids += [author_id] if respond_to?(:author_id)
    notify(type, user.id, user_ids)
  end

  def verify_comments_approval
    return unless saved_change_to_approved? && respond_to?(:comments)
    Comment.where(commentable: [self, comments])
           .update_all(approved_commentable: approved)
  end
end
