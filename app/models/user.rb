class User < ActiveRecord::Base

  attr_reader :password_confirmation

  attr_accessor :email, :password
  before_save :encrypt_password
  #
  validates_confirmation_of :password # adds password_confirmation attribute
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  # def self.authenticate(email, password)
  #   user = find_by_email(email)
  #   if user && user.passwçord_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  #     user
  #   else
  #     nil
  #   end
  # end
  #
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
