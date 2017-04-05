# frozen_string_literal: true
class Api::V1::BaseSerializer
  include JSONAPI::Serializer

  def self_link
    false
  end
end
