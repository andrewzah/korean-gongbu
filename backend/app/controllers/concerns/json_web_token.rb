# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern
  JWT_SECRET = Rails.application.secrets.secret_key_base

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end

  def jwt_decode(token)
    begin
      body = JWT.decode(token, JWT_SECRET)
      if body
        HashWithIndifferentAccess.new(body[0])
      else
        return false
      end
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      return false
    rescue JWT::DecodeError, JWT::VerificationError => e
      return false
    end
  end
end
