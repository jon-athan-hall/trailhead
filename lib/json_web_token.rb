require 'jwt'

class JsonWebToken
  def self.encode(payload)
    # Sign the payload with meta data like expiration.
    payload.reverse_merge!(meta)

    # Encode payload and application's key, using jwt gem.
    JWT.encode(payload, secret_key)
  end

  def self.decode(token)
    JWT.decode(token, secret_key)
  end

  def self.valid?(payload)
      if expired?(payload) or payload['iss'] != meta[:iss] or payload['aud'] != meta[:aud]
        return false
      else
        return true
      end
  end

  # Meta data contains expiry, issuer, and audience.
  # TODO Read about JWT meta claims.
  def self.meta
    {
      exp: 7.days.from_now.to_i,
      iss: 'trailhead',
      aud: 'github.com/jon-athan-hall',
    }
  end

  def self.expired?(payload)
    Time.at(payload['exp']) < Time.now
  end

  def self.secret_key
    Rails.application.secret_key_base
  end
end