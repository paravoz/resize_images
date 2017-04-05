RspecApiDocumentation.configure do |config|
  config.docs_dir = Rails.root.join('doc', 'api')
  config.format = [:json]
  config.api_name = 'ResizeImage Documentation'

  headers_to_include = %w(Accept Content-Type Authorization ETag)

  config.response_headers_to_include = headers_to_include
  config.request_headers_to_include = headers_to_include
  config.keep_source_order = true
end
