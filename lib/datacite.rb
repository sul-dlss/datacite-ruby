# frozen_string_literal: true

require 'zeitwerk'

Zeitwerk::Loader.for_gem.setup

module Datacite
  class Error < StandardError; end
  class ValidationError < Error; end
end
