# frozen_string_literal: true


options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
  opts.add_argument('--headless')
  opts.add_argument('--window-size=1280,1024')
end

Capybara.register_driver :local_headless_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options])
end

Capybara.default_driver = :local_headless_chrome