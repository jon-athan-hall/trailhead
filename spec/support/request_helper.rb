module RequestHelper
  # Parse the JSON response to a Ruby hash.
  def json
    JSON.parse(response.body)
  end
end
