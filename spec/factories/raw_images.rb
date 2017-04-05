# frozen_string_literal: true

FactoryGirl.define do
  factory :raw_image do
    file Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'support', 'raw_image.jpg'), 'image/jpeg'
    )
    association :user_session
  end
end
