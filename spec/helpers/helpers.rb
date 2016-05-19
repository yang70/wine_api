module Helpers
  def user_token
    User.create!(email: "foo@bar.com", password: "password")

    post "/auth_user", {email: "foo@bar.com", password: "password"}

    JSON.parse(response.body, symbolize_names: true)[:auth_token]
  end
end
