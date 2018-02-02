module ActAsPolymorphic
  parse_model_name = ->(model) { "#{model.name.downcase}_id" }

  COMMENTABLE_ID_TYPES = [Article, Major].map do |model|
    parse_model_name.call(model)
  end

  LIKEABLE_ID_TYPES = [Article, Comment].map do |model|
    parse_model_name.call(model)
  end

  def find_commentable
    find_belongs_to COMMENTABLE_ID_TYPES
  end

  def find_likeable
    find_belongs_to LIKEABLE_ID_TYPES
  end

  def find_belongs_to(id_types)
    commentable_id_type = (params.keys & id_types).first
    id = params[commentable_id_type.to_sym]
    commentable_id_type.gsub('_id', '').classify.constantize.find(id)
  end
end
