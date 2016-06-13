require 'rails_helper'

RSpec.describe "wines api", :type => :request do

  before(:context) do

    create(:user_with_wines)
    create(:user_with_wines)
  end

  describe "check happy and sad paths for requests to the API" do
  
    it "returns all wines for first user with authenticated GET request to /wines" do
      test_user = User.first
      token = user_token(test_user)

      user_wines = Wine.where(user: test_user)

      get "/wines", nil, {'Authorization' => token}

      expect(response).to be_success

      expect(response_as_json.length).to eq(2)
      expect(response_as_json[0][:name]).to eq(user_wines[0].name)
      expect(response_as_json[0][:user][:id]).to eq(test_user.id)
      expect(response_as_json[1][:name]).to eq(user_wines[1].name)
      expect(response_as_json[1][:user][:id]).to eq(test_user.id)
    end

    it "returns error with un-authenticated GET request to /wines" do
      get "/wines"

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "returns one wine with authenticated GET request to /wines/:id" do
      test_user = User.first

      token = user_token(test_user)

      test_wine = Wine.where(user_id: test_user.id)[0]

      get "/wines/#{test_wine.id}", nil, {'Authorization' => token}

      expect(response).to be_success

      expect(response_as_json[:name]).to eq(test_wine.name)
    end

    it "returns error with non-authenticated GET request to /wines/:id" do
      test_wine = Wine.where(user_id: User.first.id)[0]

      get "/wines/#{test_wine.id}"

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "returns not authorized error when trying to access another users wine" do
      test_user_1 = User.first
      test_user_2 = User.last

      test_user_1_token = user_token(test_user_1)

      test_wine = Wine.where(user_id: test_user_2.id)[0]

      get "/wines/#{test_wine.id}", nil, {'Authorization' => test_user_1_token}

      expect(response_as_json[:errors][0]).to eq("You are not authorized to access this page.")
    end

    it "creates a wine with authenticated create POST to /wines" do
      test_user = User.first
      token = user_token(test_user)

      post "/wines", {wine: {name: "created wine"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("created wine")
    end

    it "returns 422 error with authenticated create POST with invalid data" do
      test_user = User.first
      token = user_token(test_user)

      post "/wines", {wine: {name: nil}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
    end

    it "returns an error with non-authenticated POST to /wines" do
      post "/wines", wine: {name: "created wine"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "updates a wine with authenticated PATCH to /wines/:id" do
      test_user = User.first
      token = user_token(test_user)

      test_update_wine = Wine.where(user_id: test_user.id)[0]

      patch "/wines/#{test_update_wine.id}", {wine: {name: "updated name"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("updated name")

      get "/wines/#{test_update_wine.id}", nil, {'Authorization' => token}
      expect(response_as_json[:name]).to eq("updated name")
    end

    it "returns 422 error with authenticated PATCH attempt with invalid data" do
      test_user = User.first
      token = user_token(test_user)

      test_update_wine = Wine.where(user_id: test_user.id)[0]

      patch "/wines/#{test_update_wine.id}", {wine: {name: ""}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
      expect(response_as_json[:name][0]).to eq("can't be blank")
    end

    it "returns an error with non-authenticated PATCH to /wines/:id" do
      test_user = User.first
      test_update_wine = Wine.where(user_id: test_user.id)[0]

      patch "/wines/#{test_update_wine.id}", wine: {name: "updated name"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "returns not authorized error when attempting PATCH to another person's wine" do
      test_user_1 = User.first
      test_user_2 = User.last

      test_user_1_token = user_token(test_user_1)

      test_user_2_wine = Wine.where(user_id: test_user_2.id)[0]
      original_name = test_user_2_wine.name

      patch "/wines/#{test_user_2_wine.id}", {wine: {name: "should not work"}}, {'Authorization' => test_user_1_token}

      expect(response_as_json[:errors][0]).to eq("You are not authorized to access this page.")
      expect(original_name).to eq(Wine.where(user_id: test_user_2.id)[0].name)
    end

    it "updates a wine with authenticated PUT to /wines/:id" do
      test_user = User.first
      token = user_token(test_user)

      test_update_wine = Wine.where(user_id: test_user.id)[0]

      put "/wines/#{test_update_wine.id}", {wine: {name: "updated name"}}, {'Authorization' => token}

      expect(response).to be_success
      expect(response_as_json[:name]).to eq("updated name")

      get "/wines/#{test_update_wine.id}", nil, {'Authorization' => token}
      expect(response_as_json[:name]).to eq("updated name")
    end

    it "returns 422 error with authenticated PUT attempt with invalid data" do
      test_user = User.first
      token = user_token(test_user)

      test_update_wine = Wine.where(user_id: test_user.id)[0]

      put "/wines/#{test_update_wine.id}", {wine: {name: ""}}, {'Authorization' => token}

      expect(response).to have_http_status(422)
      expect(response_as_json[:name][0]).to eq("can't be blank")
    end

    it "returns an error with non-authenticated PUT to /wines/:id" do
      test_user = User.first
      test_update_wine = Wine.where(user_id: test_user.id)[0]

      put "/wines/#{test_update_wine.id}", wine: {name: "updated name"}

      expect(response).to have_http_status(401)
      expect(response_as_json[:errors][0]).to eq("Not Authenticated")
    end

    it "returns not authorized error when attempting PUT to another person's wine" do
      test_user_1 = User.first
      test_user_2 = User.last

      test_user_1_token = user_token(test_user_1)

      test_user_2_wine = Wine.where(user_id: test_user_2.id)[0]
      original_name = test_user_2_wine.name

      put "/wines/#{test_user_2_wine.id}", {wine: {name: "should not work"}}, {'Authorization' => test_user_1_token}

      expect(response_as_json[:errors][0]).to eq("You are not authorized to access this page.")
      expect(original_name).to eq(Wine.where(user_id: test_user_2.id)[0].name)
    end

    it "deletes a wine with authenticated DELETE to /wines/:id" do
      test_user = User.first
      token = user_token(test_user)

      user_1_wines_original_length = Wine.where(user_id: test_user.id).length

      test_delete_wine = create(:wine, name: "delete me", varietal: "Variety 3", quantity: 1, user: test_user )

      expect(user_1_wines_original_length + 1).to eq(Wine.where(user_id: test_user.id).length)

      delete "/wines/#{test_delete_wine.id}", nil, {'Authorization' => token}

      expect(response).to be_success
      expect(Wine.where(user_id: test_user.id).length).to eq(user_1_wines_original_length)
    end

    it "returns 'Not Authenticated' with non-authenticated DELETE to /wines/:id" do
      test_user = User.first

      test_user_wines_original_length = Wine.where(user_id: test_user.id).length

      test_delete_wine = create(:wine, name: "delete me", varietal: "Variety 3", quantity: 1, user: test_user )

      delete "/wines/#{test_delete_wine.id}"

      expect(response).to have_http_status(401)
      expect(Wine.where(user_id: test_user.id).length).to eq(test_user_wines_original_length + 1)
    end

    it "returns not authorized error when attempting to delete another user's wine" do
      test_user_1 = User.first
      test_user_2 = User.last

      test_user_1_token = user_token(test_user_1)

      test_user_2_wine = Wine.where(user_id: test_user_2.id)[0]
      test_user_2_wines_original_length = Wine.where(user_id: test_user_2).length

      delete "/wines/#{test_user_2_wine.id}", nil, {'Authorization' => test_user_1_token}

      expect(response_as_json[:errors][0]).to eq("You are not authorized to access this page.")
      expect(Wine.where(user_id: test_user_2).length).to eq(test_user_2_wines_original_length)
    end

  end
end
