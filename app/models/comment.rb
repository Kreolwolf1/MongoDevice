class Comment
  include Mongoid::Document
  field :name, :type => String
  field :content, :type => String
  referenced_in :article
  referenced_in :user
end
