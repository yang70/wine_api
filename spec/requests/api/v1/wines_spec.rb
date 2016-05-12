require 'rails_helper'

RSpec.describe "wines api", :type => :request do
  it "GET to /wines returns all wines" do
    wine1 = Wine.create!(name: "Wine 1", varietal: "Variety 1", quantity: 1)
    wine2 = Wine.create!(name: "Wine 2", varietal: "Variety 2", quantity: 1)
    get "/wines"

    json = JSON.parse(response.body)
    puts "$$$$$$$$$$$$$$$$$$$$"
    p json

    expect(response).to be_success

    expect(json.length).to eq(2)
  end
end
