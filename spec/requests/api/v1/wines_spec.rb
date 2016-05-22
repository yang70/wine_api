require 'rails_helper'

RSpec.describe "wines api", :type => :request do

  before(:context) do
    host!('api.example.com')

    create(:user_with_wines)
    create(:user_with_wines)
  end

  describe "check happy and sad paths for requests to the API" do
  
    it "returns all wines with authenticated GET request to /wines" do
      test_user = User.first

      token = user_token(test_user)

      get "/wines", nil, {'Authorization' => token}

      expect(response).to be_success

      puts response_as_json

      expect(response_as_json.length).to eq(2)
      expect(response_as_json[0][:name]).to eq("Wine 1")
      expect(response_as_json[0][:user_id]).to eq(test_user.id)
      expect(response_as_json[1][:name]).to eq("Wine 2")
      expect(response_as_json[1][:user_id]).to eq(test_user.id)
    end

    it "returns error with un-authenticated GET request to /wines" do
      get "/wines"

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "returns one wine with authenticated GET request to /wines/:id" do
      token = user_token

      test_wine = @wines_arr[0]

      get "/wines/#{test_wine.id}", nil, {'Authorization' => token}

      expect(response).to be_success

      expect(response_as_json[:name]).to eq("Wine 1")
    end

    it "returns error with non-authenticated GET request to /wines/:id" do
      test_wine = @wines_arr[0]

      get "/wines/#{test_wine.id}"

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "creates a wine with authenticated create POST to /wines" do
      token = user_token

      post "/wines", {wine: {name: "created wine"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("created wine")
    end

    it "returns 422 error with authenticated create POST with invalid data" do
      token = user_token

      post "/wines", {wine: {name: nil}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
    end

    it "returns an error with non-authenticated POST to /wines" do
      post "/wines", wine: {name: "created wine"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "updates a wine with authenticated PATCH to /wines/:id" do
      token = user_token

      test_update_wine = @wines_arr[0]

      patch "/wines/#{test_update_wine.id}", {wine: {name: "updated name"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("updated name")
    end

    it "returns 422 error with authenticated PATCH attempt with invalid data" do
      token = user_token

      test_update_wine = @wines_arr[0]

      patch "/wines/#{test_update_wine.id}", {wine: {name: ""}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
      expect(response_as_json[:name][0]).to eq("can't be blank")
    end

    it "returns an error with non-authenticated PATCH to /wines/:id" do
      test_update_wine = @wines_arr[0]

      patch "/wines/#{test_update_wine.id}", wine: {name: "updated name"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "updates a wine with authenticated PUT to /wines/:id" do
      token = user_token

      test_update_wine = @wines_arr[1]

      put "/wines/#{test_update_wine.id}", {wine: {name: "updated again"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("updated again")
    end
    
    it "returns 422 error with authenticated PUT with invalid data" do
      token = user_token

      test_update_wine = @wines_arr[0]

      put "/wines/#{test_update_wine.id}", {wine: {name: ""}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
      expect(response_as_json[:name][0]).to eq("can't be blank")
    end

    it "returns 'Not Authenticated' with non-authenticated PUT to /wines/:id" do
      test_update_wine = @wines_arr[0]

      put "/wines/#{test_update_wine.id}", wine: {name: "updated again"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq('Not Authenticated')
    end

    it "deletes a wine with authenticated DELETE to /wines/:id" do
      token = user_token

      all_wines_length = Wine.all.length

      test_delete_wine = create(:wine, name: "delete me", varietal: "Variety 3", quantity: 1 )

      expect(all_wines_length + 1).to eq(Wine.all.length)

      delete "/wines/#{test_delete_wine.id}", nil, {'Authorization' => token}

      expect(response).to be_success
      expect(Wine.all.length).to eq(all_wines_length)
    end

    it "returns 'Not Authenticated' with non-authenticated DELETE to /wines/:id" do
      all_wines_length = Wine.all.length

      test_delete_wine = create(:wine, name: "delete me", varietal: "Variety 3", quantity: 1 )

      delete "/wines/#{test_delete_wine.id}"

      expect(response).to have_http_status(401)
      expect(Wine.all.length).to eq(all_wines_length + 1)
    end

  end
end
