class CommentChildSerializer < ActiveModel::Serializer
  attributes :id, :content, :commentable_id, :commentable_type

  belongs_to :author, class_name: 'User'
end
