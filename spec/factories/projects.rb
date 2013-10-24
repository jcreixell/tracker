require 'uuidtools'

FactoryGirl.define do
  factory :project do
    name 'test'
    api_key UUIDTools::UUID.timestamp_create.to_s
  end
end
