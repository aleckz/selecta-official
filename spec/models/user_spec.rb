require 'rails_helper'

describe User, type: :model do

  let!(:user) do
    # User.create(email: 'test@test.com',
    #             password: '12345678',
    #             password_confirmation: '12345678')
  end

  # it 'authenticates when given a valid email and password' do
  #   authenticated_user = User.authenticate(user.email, user.password)
  #   expect(authenticated_user).to eq user

  # end

  it 'validates presence of email' do
    user = User.new
    expect(user).to have(1).error_on(:email)
    expect(user).not_to be_valid
  end

  it 'email has to be unique ' do
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    expect(user.email).not_to be_valid
  end
end
