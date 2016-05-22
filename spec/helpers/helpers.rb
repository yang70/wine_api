module Helpers
  def user_token(user)

    post "/auth_user", {email: user.email, password: "password"}

    JSON.parse(response.body, symbolize_names: true)[:auth_token]
  end

  def response_as_json
    JSON.parse(response.body, symbolize_names: true)
  end
end

