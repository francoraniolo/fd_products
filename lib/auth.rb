require 'securerandom'

class Auth
  USERS = { 'admin' => 'password123' }
  @@sessions = {}

  def self.authenticate(user, password)
    if USERS[user] == password
      token = SecureRandom.hex(16)
      @@sessions[token] = true
      token
    end
  end

  def self.authorized?(req)
    token = req.get_header('HTTP_AUTHORIZATION')&.split&.last
    @@sessions.key?(token)
  end
end
