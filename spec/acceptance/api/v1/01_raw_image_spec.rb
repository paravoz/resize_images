# frozen_string_literal: true

require 'rails_helper'

resource 'RawImage' do
  let(:user_session) { UserSession.create! }
  let(:authorization_token) { user_session.authorization_token }

  let(:file) do
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'support', 'raw_image.jpg'), 'image/jpeg'
    )
  end

  before { header 'Authorization', :authorization_token }

  get '/api/v1/raw_images' do
    header 'Content-Type', 'application/vnd.api+json'

    parameter :page, 'Page to view', 'Type' => 'Integer'

    example 'Retrieve paginated list of uploaded images', document: :public do
      2.times { create(:raw_image, user_session: user_session) }

      do_request
      expect(status).to eq 200
    end

    example 'Unauthorized request to list of uploaded images', document: false do
      header 'Authorization', nil

      do_request
      expect(status).to eq 401
    end
  end

  get '/api/v1/raw_images/:id' do
    let(:id) { create(:raw_image, user_session: user_session).id }

    example 'Getting a specific uploaded image', document: :public do
      do_request
      expect(status).to eq 200
    end
  end

  get '/api/v1/raw_images/:id' do
    let(:id) { create(:raw_image).id }

    example 'Uploaded image not found', document: false do
      do_request
      expect(status).to eq 404
    end
  end

  post '/api/v1/raw_images' do
    header 'Content-Type', 'multipart/form-data'

    parameter :file, 'Attachment', 'Type' => 'Multipart/Form-data', required: true

    example 'Upload image on server', document: :public do
      do_request(file: file)
      expect(response_status).to eq(200)
    end

    example 'Upload empty image', document: false do
      do_request(file: nil)

      expect(status).to eq 422
      # expect(json_response[:errors])
    end
  end
end
