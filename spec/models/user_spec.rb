require 'spec_helper'

describe User do
  let!(:user) { User.create(email: 'johndoe@internet.com', password: 'test', password_confirmation: 'test') }

  it '#authenticate works with correct email & password' do
    authenticated = User.authenticate(user.email, user.password)
    expect(authenticated).to eq user
  end

  it '#authenticate fails with incorrect email & password' do
    expect(User.authenticate(user.email, 'me_drunk')).to be nil
  end

  it '#generate_token changes password_token' do
    expect{user.generate_token}.to change{user.password_token}
  end

  it 'saves password token time when generating a token' do
    Timecop.freeze do
      user.generate_token
      expect(user.password_token_time).to eq Time.now
    end
  end

  it 'finds user with valid token' do
    user.generate_token
    expect(User.find_by_valid_token(user.password_token)).to eq user
  end

  it 'does not find user with token older than 1 hour' do
    user.generate_token
    Timecop.travel(3700) do
      expect(User.find_by_valid_token(user.password_token)).to eq nil
    end
  end
end
