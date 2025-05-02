module RequestHelpers
  def json_response
    JSON.parse(response.body)
  rescue JSON::ParserError => e
    raise "Failed to parse JSON: #{e}\nResponse body: #{response.body.inspect}"
  end
end
