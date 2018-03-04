class RelationSerializer < ActiveModel::Serializer::CollectionSerializer
  def initialize(relation, options = {})
    if options[:serializer].respond_to?(:eager_load_relation)
      relation = options[:serializer].eager_load_relation(relation)
    end

    super(relation, options)
  end
end
