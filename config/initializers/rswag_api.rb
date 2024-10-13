Rswag::Api.configure do |c|
  c.openapi_root = Rails.root.join('openapi')
  c.swagger_headers = { 'Content-Type' => 'application/json; charset=UTF-8' }

  # Inject a lambda function to alter the returned Swagger prior to serialization
  # The function will have access to the rack env for the current request

  #c.swagger_filter = lambda { |swagger, env| swagger['host'] = env['HTTP_HOST'] }
end
