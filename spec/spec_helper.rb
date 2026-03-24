# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'shared_examples'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.log_level = :error
end
