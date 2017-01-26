require 'spec_helper'

feature 'Signing up' do
  scenario 'as new user and increase' do
    expect { sign_up }.to change(User, :count).by 1
    expect(page).to have_content 'Welcome johndoe@internet.com'
    expect(User.first.email).to eq('johndoe@internet.com')
  end

  scenario 'with proper password confirmation' do
    expect { sign_up(password_confirmation: 'otherpassword')}.not_to change(User, :count)
  end

  scenario 'with improper password confirmation' do
    expect { sign_up(password_confirmation: 'otherpassword')}.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario "without email address" do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email must not be blank')
  end

  scenario "with invalid email address" do
    expect { sign_up(email: 'been@drinking') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario "with existing email" do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end
end

feature 'Signing in' do
  let!(:user) { User.create(email: 'johndoe@internet.com', password: 'test', password_confirmation: 'test') }

  scenario 'with correct email & password' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome #{user.email}"
  end
end

feature 'Signing out' do
  before(:each) { User.create(email: 'johndoe@internet.com', password: 'test', password_confirmation: 'test') }

  scenario 'if signed in' do
    sign_in(email: 'johndoe@internet.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content 'Sayonara!'
    expect(page).not_to have_content 'Welcome johndoe@internet.com'
  end
end
