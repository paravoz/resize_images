# frozen_string_literal: true
class Api::V1::RawImageSerializer < Api::V1::BaseSerializer
  attribute :file_url do
    "/uploads/#{object.file_identifier}"
  end
end
