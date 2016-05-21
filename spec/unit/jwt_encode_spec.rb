require 'rails_helper'

RSpec.describe "JWT encoding and decoding", :type => :unit do
  before(:each) do
    User.create!(email: 'foo@bar.com', password: 'password')
  end

  it "returns a propper JWT token with user id" do
    user = User.first
    payload = {user_id: user.id} 
    token = JsonWebToken.encode(payload)

    decoded = JsonWebToken.decode(token)
    expect(decoded[:user_id]).to eq(user.id)
  end

  it "returns nil if JWT is expired" do
    user = User.first
    payload = {user_id: user.id}
    
    # Create expired token by sending in time of a month ago
    token = JsonWebToken.encode(payload, (0 - 60 * 24 * 30))

    decoded = JsonWebToken.decode(token)
    expect(decoded).to be_nil
  end
end
