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

  def sign_up(email: 'johndoe@internet.com', password: 'password', password_confirmation: 'password')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

end
