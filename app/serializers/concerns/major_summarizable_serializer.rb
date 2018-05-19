module MajorSummarizableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :major_summary
  end

  def major_summary
    return nil unless object.major
    MajorSummarySerializer.new(object.major)
  end
end
