require 'byebug'
require 'rails'
require 'action_controller/railtie'

module RSpecCells
  class Application < ::Rails::Application
    config.secret_token = 'x'*30
    config.eager_load = false
  end
end
I18n.enforce_available_locales = true if I18n.respond_to?(:enforce_available_locales)

require 'rspec/cells'
require 'ammeter/init'



RSpecCells::Application.initialize!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
