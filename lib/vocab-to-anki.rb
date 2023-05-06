# frozen_string_literal: true

require "csv"
require "faraday"
require "capybara/sessionkeeper"
require "selenium-webdriver"

require_relative "vocab_to_anki/cards_helper"
require_relative "vocab_to_anki/configuration"
require_relative "vocab_to_anki/references"
require_relative "vocab_to_anki/references/macmillan_dictionary"
require_relative "vocab_to_anki/references/google_translate"
require_relative "vocab_to_anki/references/merriam_webster"
require_relative "vocab_to_anki/version"

module AnkiTranslator
  class Error < StandardError; end

  Capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless") if configuration.headless_mode
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.register_driver :firefox do |app|
    options = Selenium::WebDriver::Firefox::Options.new
    options.add_argument("--headless") if configuration.headless_mode

    Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
  end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
