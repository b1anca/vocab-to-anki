# frozen_string_literal: true

require "dotenv"
require "csv"
require "faraday"
require "capybara/sessionkeeper"

require_relative "anki_translator/cards_helper"
require_relative "anki_translator/references"
require_relative "anki_translator/references/macmillan_dictionary"
require_relative "anki_translator/references/google_translate"
require_relative "anki_translator/references/merriam_webster"
require_relative "anki_translator/version"

Dotenv.load

module AnkiTranslator
  class Error < StandardError; end

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
end
