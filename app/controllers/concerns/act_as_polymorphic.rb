module ActAsPolymorphic
  parse_model = proc { |model| "#{model.name.downcase}_id" }

  ID_TYPES = {
    commentable: [Major, Article, Discussion, Comment].map(&parse_model),
    likeable: [Article, Discussion, Comment].map(&parse_model),
    enrollable: [Article, Discussion, Comment].map(&parse_model),
    video_linkable: [Major].map(&parse_model)
  }.freeze

  def method_missing(name)
    name =~ /find_(commentable|likeable|enrollable|video_linkable)/
    match = Regexp.last_match(1)
    match ? find_belongs_to(ID_TYPES[match.to_sym]) : super
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('find_') || super
  end

  def find_belongs_to(id_types)
    id_type = (params.keys & id_types).first
    id = params[id_type.to_sym]
    id_type.gsub('_id', '').classify.constantize.find(id)
  end
end
