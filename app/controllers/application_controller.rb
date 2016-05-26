class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  attr_reader :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: ["#{exception.message}"] }
  end

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end 

  private
  def http_token
    @http_token ||= request.headers['Authorization'] if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
