# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response_body, symbolize_names: true)
    end

    def unauthorized_response
      { errors: [{ status: 401, title: 'Unauthorized' }] }
    end

    def not_found_response
      { errors: ['Document(s) not found'] }
    end

    def raw_image_validation_errors
      {
        errors:
          [
            {
              source: { pointer: '/data/attributes/file' },
              detail: "File can't be blank"
            }
          ]
      }
    end

    def resize_image_validation_errors
      {
        errors:
          [
            {
              source: { pointer: '/data/attributes/raw-image' },
              detail: "Raw image can't be blank"
            },
            {
              source: { pointer: '/data/attributes/raw-image' },
              detail: "Raw image can't be blank"
            },
            { source: { pointer: '/data/attributes/width' },
              detail: "Width can't be blank"
            },
            {
              source: { pointer: '/data/attributes/width' },
              detail: 'Width is not a number'
            },
            {
              source: { pointer: '/data/attributes/height' },
              detail: "Height can't be blank"
            },
            {
              source: { pointer: '/data/attributes/height' },
              detail: 'Height is not a number'
            }
          ]
      }
    end
  end
end
