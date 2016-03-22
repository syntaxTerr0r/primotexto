require "primotexto/client"
require "primotexto/version"

module Primotexto
  def self.client(options = {})
    Client.new(options)
  end

  class Error < StandardError; end
  class AuthenticationError < Error; end
end
