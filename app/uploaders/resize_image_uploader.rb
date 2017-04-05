# frozen_string_literal: true

class ResizeImageUploader < CarrierWave::Uploader::Base
  include Configurable
  storage :file
end
