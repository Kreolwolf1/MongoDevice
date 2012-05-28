class Article
  include Mongoid::Document
  field :name, :type => String
  field :content, :type => String
  field :published_on, :type => Date
  validates_presence_of :name
  references_many :comments
  referenced_in :user

end
