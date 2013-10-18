require 'rspec/core/rake_task'
require 'uuidtools'

task :default => :spec

task :environment do |task|
	require File.expand_path('../app', __FILE__)
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

namespace :projects do
  task :create, [:name] => :environment do |task, args|
    raise StandardError.new("Missing parameter: name") unless args[:name].present?

    project = Project.create!(name: args[:name], api_key: UUIDTools::UUID.timestamp_create.to_s)
    puts "Project created"
    puts "  Name: #{project.name}"
    puts "  API_key: #{project.api_key}"
  end
end
