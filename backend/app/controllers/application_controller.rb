class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request
  wrap_parameters format: [:json]

  private

  def authenticate_request
    header = request.headers["Authorization"]
    if header.nil?
      render json: {
        'errors': [
          'Authorization header not found.'
        ]
      }, status: :bad_request
      return
    end
    header = header.split(" ").last

    begin
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue => err
      render json: {
        'errors': [
          "[#{err.class}] #{err.message}"
        ]
      }, status: :internal_server_error
      return
    end
  end

  #def authenticate_cookie
  #  token = cookies.signed[:jwt]
  #  decoded_token = CoreModules::JsonWebToken.decode(token)

  #  if decoded_token
  #    user = User.find_by(id: decoded_token["user_id"])
  #  end

  #  if user then return true else render json: {status: 'unauthorized', code: 401} end
  #end

  #def current_user
  #  token = cookies.signed[:jwt]
  #  decoded_token = CoreModules::JsonWebToken.decode(token)

  #  if decoded_token
  #    user = User.find_by(id: decoded_token["user_id"])
  #  end

  #  if user then return user else return false end
  #end
end
