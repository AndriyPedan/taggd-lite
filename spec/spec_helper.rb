require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/app/channels'
  add_filter '/app/mailers'
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
  Dir['app/*'].each do |dir|
    add_group File.basename(dir), dir
  end
  minimum_coverage 95 unless ENV['CIRCLE_JOB']
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
