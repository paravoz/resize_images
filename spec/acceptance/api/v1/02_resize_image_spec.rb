# frozen_string_literal: true

require 'rails_helper'

resource 'ResizeImage' do
  let(:user_session) { UserSession.create! }
  let(:authorization_token) { user_session.authorization_token }
  let(:raw_image) { create(:raw_image, user_session: user_session) }

  before do
    header 'Content-Type', 'application/vnd.api+json'
    header 'Authorization', :authorization_token
  end

  get '/api/v1/resize_images' do
    parameter :page, 'Page to view', 'Type' => 'Integer'

    example 'Retrieve paginated list of resized images', document: :public do
      2.times { create(:resize_image, raw_image: raw_image) }

      do_request
      expect(status).to eq 200
    end

    example 'Unauthorized request to list of resized images', document: false do
      header 'Authorization', nil

      do_request
      expect(status).to eq 401
    end
  end

  get '/api/v1/resize_images/:id' do
    let(:id) { create(:resize_image, raw_image: raw_image).id }

    example 'Getting a specific resized image', document: :public do
      do_request
      expect(status).to eq 200
    end
  end

  get '/api/v1/resize_images/:id' do
    let(:id) { create(:resize_image).id }

    example 'Resized image not found', document: false do
      do_request
      expect(status).to eq 404
    end
  end

  post '/api/v1/resize_images' do
    parameter :raw_image_id, 'Id uploaded image for resize', 'Type' => 'String', required: true
    parameter :width, 'width in pixel', 'Type' => 'Integer', required: true
    parameter :height, 'height in pixel', 'Type' => 'Integer', required: true

    let(:raw_image_id) { raw_image.id.to_s }
    let(:width) { 5 }
    let(:height) { 5 }

    let(:raw_post) do
      { data: { type: 'resize-images', attributes: params } }.to_json
    end

    example 'Create resize image', document: :public do
      do_request
      expect(response_status).to eq(200)
    end
  end

  post '/api/v1/resize_images' do
    let(:raw_post) { params.to_json }

    example 'Create resize image', document: false do
      do_request
      expect(response_status).to eq(422)
    end
  end
end
