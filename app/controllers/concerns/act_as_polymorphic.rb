module ActAsPolymorphic
  parse_model = proc { |model| "#{model.name.downcase}_id" }

  ID_TYPES = {
    commentable: [Major, Article, Discussion].map(&parse_model),
    likeable: [Article, Discussion, Comment].map(&parse_model),
    enrollable: [Article, Discussion, Comment].map(&parse_model)
  }.freeze

  def method_missing(name)
    name =~ /find_(commentable|likeable|enrollable)/
    match = Regexp.last_match(1)
    match ? find_belongs_to(ID_TYPES[match.to_sym]) : super
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('find_') || super
  end

  def find_belongs_to(id_types)
    commentable_id_type = (params.keys & id_types).first
    id = params[commentable_id_type.to_sym]
    commentable_id_type.gsub('_id', '').classify.constantize.find(id)
  end
end
