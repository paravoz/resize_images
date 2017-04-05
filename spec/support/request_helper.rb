# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response_body, symbolize_names: true)
    end
  end
end
