# frozen_string_literal: true

require 'rails_helper'

resource 'UserSession' do
  post '/api/v1/user_sessions' do
    header 'Content-Type', 'application/vnd.api+json'

    example 'Create new User Session', document: :public do
      explanation(
        'This method creates a new session. With authorization-token ' \
        'is unique key which is used to subscribe user requests'
      )

      do_request

      expect(status).to eq 200

      expect(json_response.dig(:data, :type)).to eq('user-sessions')

      expect(json_response.dig(:data, :id)).to_not be_nil

      expect(
        json_response.dig(:data, :attributes, :'authorization-token')
      ).to_not be_nil
    end
  end
end
