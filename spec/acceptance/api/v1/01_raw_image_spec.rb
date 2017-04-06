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

      list_images = json_response[:data]

      expect(list_images.count).to eq 2

      image_data = list_images.first

      expect(image_data[:type]).to eq('raw-images')
      expect(image_data[:id]).to_not be_nil
      expect(image_data.dig(:attributes, :'file-url')).to_not be_nil

      expect(json_response[:links]).not_to be_empty
    end

    example 'Unauthorized request to list of uploaded images', document: false do
      header 'Authorization', nil

      do_request

      expect(status).to eq 401

      expect(json_response).to eq(unauthorized_response)
    end
  end

  get '/api/v1/raw_images/:id' do
    let(:id) { create(:raw_image, user_session: user_session).id }

    example 'Getting a specific uploaded image', document: :public do
      do_request

      expect(status).to eq 200

      expect(json_response.dig(:data, :type)).to eq('raw-images')
      expect(json_response.dig(:data, :id)).to_not be_nil
      expect(json_response.dig(:data, :attributes, :'file-url')).to_not be_nil
    end
  end

  get '/api/v1/raw_images/:id' do
    let(:id) { create(:raw_image).id }

    example 'Uploaded image not found', document: false do
      do_request

      expect(status).to eq 404

      expect(json_response).to eq(not_found_response)
    end
  end

  post '/api/v1/raw_images' do
    header 'Content-Type', 'multipart/form-data'

    parameter :file, 'Attachment', 'Type' => 'Multipart/Form-data', required: true

    example 'Upload image on server', document: :public do
      do_request(file: file)

      expect(response_status).to eq(200)

      expect(json_response.dig(:data, :type)).to eq('raw-images')
      expect(json_response.dig(:data, :id)).to_not be_nil
      expect(json_response.dig(:data, :attributes, :'file-url')).to_not be_nil
    end

    example 'Upload empty image', document: false do
      do_request(file: nil)

      expect(status).to eq 422

      expect(json_response).to eq(raw_image_validation_errors)
    end
  end
end
