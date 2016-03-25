require 'active_support/inflector'
require "primotexto/client/constants"
require "primotexto/client/http"

module Primotexto
  class Client
    attr_reader :key

    def initialize(options = {})
      @key = options.fetch(:key) { ENV.fetch('PRIMOTEXTO_API_KEY') }
    end

    class << self
      def ids_to_params(ids)
        ids.map { |id| id_to_param(id) }
      end

      def id_to_param(id)
        parts = id.split('-')
        name = ActiveSupport::Inflector.singularize(parts.first)
        parts[0] = name
        parts.join('_').to_sym
      end

      private

      def no_params_behaviour(verb, uri)
        -> { send(verb, uri) }
      end

      def params_behaviour(verb, uri)
        -> (params) { send(verb, uri, params) }
      end

      def params_with_ids_behaviour(verb, method, ids)
        lambda do |params|
          # Validating uri params presence
          Client.ids_to_params(ids).each do |pid|
            fail Error, "The '#{pid}' params is mandatory for this method" unless params.include?(pid)
          end

          method_with_ids = method.dup

          # Replacing values
          ids.each do |pid|
            param_name = pid.split('-').first
            param_value = params[Client.id_to_param(pid)]
            method_with_ids.map! do |v|
              (v == pid) ? "#{param_name}/#{param_value}" : v
            end
          end

          uri = '/'
          uri += method_with_ids.join('/')
          send(verb, uri, params)
        end
      end
    end

    API_METHODS_MAP.each do |api_method|
      if api_method.is_a?(Array)
        friendly_method = api_method.first
        api_method = api_method.last
      end

      method = api_method.split('_')
      with_params = api_method.include?('params')
      method.pop if with_params

      ids = method.select { |i| i.include?('-id') }

      friendly_method = method.join('_') if friendly_method.nil?
      verb = method.shift
      uri = '/'
      uri += method.join('/')

      if with_params
        behaviour = (ids.any?) ? params_with_ids_behaviour(verb, method, ids) : params_behaviour(verb, uri)
      else
        behaviour = no_params_behaviour(verb, uri)
      end
      define_method(friendly_method.to_sym, &behaviour)
    end
  end
end
