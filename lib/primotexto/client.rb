require "primotexto/client/constants"
require "primotexto/client/http"

module Primotexto
  class Client
    attr_reader :key

    def initialize(options = {})
      @key = options.fetch(:key) { ENV.fetch('PRIMOTEXTO_API_KEY') }
    end

    API_METHODS_MAP.each do |api_method|
      if api_method.is_a?(Array)
        friendly_method = api_method.first
        api_method = api_method.last
      end

      method = api_method.split('_')
      with_params = api_method.include?('params')
      method.pop if with_params
      friendly_method = method.join('_') if friendly_method.nil?
      verb = method.shift
      uri = '/'
      uri += method.join('/')

      if with_params
        behaviour = -> (params) { send(verb, uri, params) }
      else
        behaviour = -> { send(verb, uri) }
      end
      define_method(friendly_method.to_sym, &behaviour)
    end
  end
end
