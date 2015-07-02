require 'rspec/core/rake_task'
require 'dm-core'
require 'dm-migrations'
# Model Classes
require_relative 'src/tweet'
require_relative 'src/user'
require_relative 'src/uuid'

RSpec::Core::RakeTask.new(:spec)

task 'db:migrate' do
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, 'postgres://admin:admin@localhost/myapp')
  DataMapper.auto_upgrade!
  self
end

task default: :spec
