ActiveModelSerializers.config.tap do |config|
  config.default_includes = '**'
  config.collection_serializer = RelationSerializer
end
