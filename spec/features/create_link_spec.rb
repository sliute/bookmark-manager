require 'spec_helper'

feature 'Seeing links' do

  scenario 'on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
    link = Link.all(title: 'Makers Academy')
    link.destroy
  end

  scenario 'on the links/new page' do
    visit '/links/new'
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    click_button 'Add'
    within 'ul#links' do
      expect(page).to have_content('Google')
    end
    Link.all(title: 'Google').destroy
  end
end
