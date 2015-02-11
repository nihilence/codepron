class User < ActiveRecord::Base
  attr_reader :password
  has_many :previews, foreign_key: "author_id", class_name:"Preview"
  has_many :comments, foreign_key: "author_id", class_name:"Comment"
  has_many :followers, foreign_key: "followed_id", class_name: "User"
  has_many :followed_users, foreign_key: "follower_id", class_name: "User"

  after_initialize :ensure_session_token
  validate :email, presence: true
  validate :password, length: {minimum: 6}

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    if user.is_password?(password)
      return user
    else
      return nil
    end
  end


  private

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end


end
