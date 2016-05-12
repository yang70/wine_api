require 'rails_helper'

RSpec.describe "wines api", :type => :request do
  
  it "returns all wines with GET request to /wines" do
    host!('api.example.com')

    wine1 = Wine.create!(name: "Wine 1", varietal: "Variety 1", quantity: 1)
    wine2 = Wine.create!(name: "Wine 2", varietal: "Variety 2", quantity: 1)

    get "/wines"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json[0][:name]).to eq("Wine 1")
    expect(json[1][:name]).to eq("Wine 2")
  end
end
