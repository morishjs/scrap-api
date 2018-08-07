class JsonWebToken
  def self.encode(token)
    exp = 60.days.from_now.to_i
    payload = { data: token, exp: exp }

    JWT.encode payload, Rails.application.secret_key_base
  end

  def self.decode(s)
    JWT.decode(s, Rails.application.secret_key_base).first['data']
  end
end