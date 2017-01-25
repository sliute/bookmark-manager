require 'spec_helper'

feature 'Seeing links' do

  scenario 'on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'on the links/new page' do
    visit_fill
    within 'ul#links' do
      expect(page).to have_content('Google')
    end
  end

  scenario 'and add a tag' do
    visit_fill_1_tag
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include('Search Engine')
  end
end
