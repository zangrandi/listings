require "capybara"
require "capybara/poltergeist"

Capybara.register_driver :poltergeist_no_js do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end