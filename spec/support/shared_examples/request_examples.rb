# Shared example for testing the status code that is returned by a request.
RSpec.shared_examples 'status code' do |status_code|
  it "returns status code #{status_code}" do
    expect(response).to have_http_status(status_code)
  end
end
