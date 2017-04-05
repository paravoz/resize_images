# frozen_string_literal: true

class RawImageUploader < CarrierWave::Uploader::Base
  include Configurable
  storage :file
end
