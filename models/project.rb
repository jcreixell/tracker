class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :api_key, type: String
end
