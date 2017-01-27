require 'spec_helper'

feature 'Resetting password' do
  before do
    sign_up
    Capybara.reset!
    allow(SendRecoverLink).to receive(:call)
  end

  let(:user) { User.first }

  scenario 'via link to reset' do
    visit '/sessions/new'
    click_link 'Password forgotten?'
    expect(page).to have_content 'Please enter your email address to reset your password'
  end

  scenario 'by being redirected to email' do
    recover_password
    expect(page).to have_content 'Cheers. Please check your email for further instructions.'
  end

  scenario 'by receiving a token to reset it' do
    sign_up
    expect{ recover_password }.to change{User.first.password_token}
  end

  scenario 'no later than 1 hour' do
    recover_password
    Timecop.travel(216000) do
      visit "/users/reset_password?token=#{user.password_token}"
      expect(page).to have_content 'Invalid token'
    end
  end

  scenario 'if the token is valid' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    expect(page).to have_content 'Please enter a new password'
  end

  scenario 'enter new password with valid token in less than 1 hour' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in :password, with: 'new pass'
    fill_in :password_confirmation, with: 'new pass'
    click_button 'Submit'
    expect(page).to have_content 'Sign in to use Bookmark Manager'
  end

  scenario 'lets you sign in after password reset' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in :password, with: 'new pass'
    fill_in :password_confirmation, with: 'new pass'
    click_button 'Submit'
    sign_in(email: 'johndoe@internet.com', password: 'new pass')
    expect(page).to have_content 'Welcome johndoe@internet.com'
  end

  scenario 'raises error if passwords do not match' do
    recover_password
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in :password, with: 'new pass'
    fill_in :password_confirmation, with: 'been_drinkin'
    click_button 'Submit'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'immediately resets token upon successful password update' do
    recover_password
    set_password(password: 'new pass', password_confirmation: 'new pass')
    visit "/users/reset_password?token=#{user.password_token}"
    expect(page).to have_content 'Invalid token'
  end

  def set_password(password:, password_confirmation:)
    visit "/users/reset_password?token=#{user.password_token}"
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Submit'
  end

  scenario 'calls SendRecoverLink to send link' do
    expect(SendRecoverLink).to receive(:call).with(user)
    recover_password
  end

end
