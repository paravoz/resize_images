# frozen_string_literal: true
class Api::V1::ResizeImageSerializer < Api::V1::BaseSerializer
  attributes :width, :height

  attribute :file_url do
    "/uploads/#{object.file_identifier}"
  end
end
