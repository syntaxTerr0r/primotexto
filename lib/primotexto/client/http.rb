require 'net/http'
require 'json'
require 'cgi'
require 'active_support/core_ext/object/try'

module Primotexto
  class Client
    private

    def get(path, params = {})
      uri = full_url_with(path)
      uri.query = query_string(params)
      get_request = Net::HTTP::Get.new(uri.request_uri)
      get_request['X-Primotexto-ApiKey'] = @key
      get_request['Content-Type'] = 'application/json'
      parse query(uri.host, get_request)
    end

    def post(path, params)
      uri = full_url_with(path)
      post_request = Net::HTTP::Post.new(uri.request_uri)
      post_request['X-Primotexto-ApiKey'] = @key
      post_request['Content-Type'] = 'application/json'
      post_request.body = params.to_json
      parse query(uri.host, post_request)
    end

    def delete(path, params)
      uri = full_url_with(path)
      uri.query = query_string(params)
      delete_request = Net::HTTP::Delete.new(uri.request_uri)
      delete_request['X-Primotexto-ApiKey'] = @key
      delete_request['Content-Type'] = 'application/json'
      parse query(uri.host, delete_request)
    end

    def query(host, http_request)
      http = Net::HTTP.new(host, Net::HTTP.https_default_port)
      http.use_ssl = true
      http.request(http_request)
    end

    def full_url_with(path)
      URI.join("https://#{API_HOST}", "/v2#{path}")
    end

    def parse(http_response)
      case http_response
      when Net::HTTPSuccess
        if http_response['Content-Type'].try(:split, ';').try(:first) == 'application/json'
          JSON.parse!(http_response.body, symbolize_names: true)
        else
          http_response.body
        end
      when Net::HTTPUnauthorized
        fail AuthenticationError
      else
        error_code = JSON.parse(http_response.body)['code']
        fail Error, "#{ERROR_CODES[error_code]} (code: #{error_code})"
      end
    end

    def query_string(params)
      params.flat_map { |k, vs| Array(vs).map { |v| "#{escape(k)}=#{escape(v)}" } }.join('&')
    end

    def escape(component)
      CGI.escape(component.to_s)
    end
  end
end
