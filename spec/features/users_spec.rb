require 'spec_helper'

feature 'Signing up' do
  scenario 'as new user and increase' do
    expect { sign_up }.to change(User, :count).by 1
    expect(page).to have_content 'Welcome johndoe@internet.com'
    expect(User.first.email).to eq('johndoe@internet.com')
  end
end
