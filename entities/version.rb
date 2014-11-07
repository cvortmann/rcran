require 'mongoid'

class Version
  include Mongoid::Document

  validates_presence_of :name
  validates_presence_of :number

  field :name,                type: String
  field :number,              type: String
  field :title,               type: String
  field :author,              type: String
  field :maintainer,          type: String
  field :description,         type: String
  field :date_of_publication, type: String

  index({ name: 1, number: 1 }, { unique: true })
end
