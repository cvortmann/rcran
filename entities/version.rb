require 'mongoid'

class Version
  include Mongoid::Document

  field :name,   type: String
  field :number, type: String

  index({ name: 1, number: 1 }, { unique: true })
end
