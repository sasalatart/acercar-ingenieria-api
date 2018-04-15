module Attachable
  extend ActiveSupport::Concern

  MAX_ATTACHMENTS = 5
  MAX_TOTAL_SIZE_IN_MB = 10
  MAX_TOTAL_SIZE_IN_B = MAX_TOTAL_SIZE_IN_MB.megabytes

  included do
    has_many :attachments, as: :attachable, dependent: :destroy, inverse_of: :attachable

    accepts_nested_attributes_for :attachments, allow_destroy: true

    validate :max_attachments
    validate :max_total_size
  end

  private

  def max_attachments
    return unless attachments.size > MAX_ATTACHMENTS
    errors.add :base, :max_attachments_reached, amount: MAX_ATTACHMENTS
  end

  def max_total_size
    return unless attachments.sum(&:document_file_size) > MAX_TOTAL_SIZE_IN_B
    errors.add :base, :max_attachments_size_reached, amount: MAX_TOTAL_SIZE_IN_MB
  end
end
