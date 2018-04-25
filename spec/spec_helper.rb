require "bundler/setup"
require "dynamoid_advanced_where"
require "dynamoid"
require "aws-sdk"
require "pry"

ENV['ACCESS_KEY'] ||= 'abcd'
ENV['SECRET_KEY'] ||= '1234'

Aws.config.update(
  region: 'us-west-2',
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'])
)

Dynamoid.configure do |config|
  config.endpoint = 'http://127.0.0.1:8000'
  config.namespace = 'dynamoid_tests'
  config.warn_on_scan = false
  config.sync_retry_wait_seconds = 0
  config.sync_retry_max_times = 3
end

RSpec.configure do |config|
  Dir[File.join(File.dirname(__FILE__), '/support/**/*.rb')].each { |f| require f }

  config.include ClassCreator

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
