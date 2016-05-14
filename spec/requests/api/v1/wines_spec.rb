require 'rails_helper'

RSpec.describe "wines api", :type => :request do

  before(:each) do
    host!('api.example.com')

    wine1 = Wine.create!(name: "Wine 1", varietal: "Variety 1", quantity: 1)
    wine2 = Wine.create!(name: "Wine 2", varietal: "Variety 2", quantity: 1)
  end
  
  it "returns all wines with GET request to /wines" do
    get "/wines"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json[0][:name]).to eq("Wine 1")
    expect(json[1][:name]).to eq("Wine 2")
  end

  it "returns one wine with GET request to /wines/:id" do
    test_wine = Wine.find_by(name: "Wine 1")

    get "/wines/#{test_wine.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(json[:name]).to eq("Wine 1")
  end

  it "creates a wine with POST to /wines" do
    post "/wines", wine: {name: "created wine"}

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(json[:name]).to eq("created wine")
  end

  it "returns error whith unsuccessful create" do
    post "/wines", wine: {name: nil}

    expect(response).to have_http_status(422)
  end

  it "updates a wine with PATCH to /wines/:id" do
    test_update_wine = Wine.find_by(name: "Wine 1")

    patch "/wines/#{test_update_wine.id}", wine: {name: "updated name"}

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(json[:name]).to eq("updated name")
  end

  it "returns 422 error if PATCH update fails" do
    test_update_wine = Wine.find_by(name: "Wine 1")

    patch "/wines/#{test_update_wine.id}", wine: {name: ""}

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(422)
    expect(json[:name][0]).to eq("can't be blank")
  end

  it "updates a wine with PUT to /wines/:id" do
    test_update_wine = Wine.find_by(name: "Wine 2")

    put "/wines/#{test_update_wine.id}", wine: {name: "updated again"}

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(json[:name]).to eq("updated again")
  end
  
  it "returns 422 error if PUT update fails" do
    test_update_wine = Wine.find_by(name: "Wine 1")

    put "/wines/#{test_update_wine.id}", wine: {name: ""}

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(422)
    expect(json[:name][0]).to eq("can't be blank")
  end

  it "deletes a wine with DELETE to /wines/:id" do
    all_wines = Wine.all
    test_delete_wine = Wine.create!(name: "delete me", varietal: "Variety 3", quantity: 1 )

    delete "/wines/#{test_delete_wine.id}"

    expect(response).to be_success
    expect(Wine.all).to eq all_wines
  end
end
