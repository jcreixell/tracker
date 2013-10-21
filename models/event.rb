class Event

  include Mongoid::Document
  include Mongoid::Timestamps

  field :type, type: String
  field :time, type: DateTime
  field :properties, type: Hash

  belongs_to :project, index: true

end
