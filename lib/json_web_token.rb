class JsonWebToken

  class << self
    def encode(payload, exp = 2.hours.from_now)

      # set token expiration time
      payload[:exp] = exp.to_i

      # encode user data (payload) with secret key
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)

      # decode the token to get user data (payload)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body

      # raise custom errors to be handled by customer handler
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        raise ExceptionHandler::ExpiredSignature, e.message

      rescue JWT::DecodeError, JWT::VerificationError => e
        raise ExceptionHandler::DecodeError, e.message
    end
  end
end