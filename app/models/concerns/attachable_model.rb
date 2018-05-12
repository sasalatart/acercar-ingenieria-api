module AttachableModel
  extend ActiveSupport::Concern

  included do
    has_many_attached :attachments
  end

  def purge_attachments(ids)
    attachments.where(id: ids).purge
  end
end
