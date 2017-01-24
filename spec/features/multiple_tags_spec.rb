require 'spec_helper'

feature "Adding multiple tags" do
  scenario 'to a single link' do
    visit '/links/new'
    fill_in :title, with: 'Google'
    fill_in :url, with: 'http://www.google.com'
    fill_in :tag, with: 'Search, AdWords'
    click_button 'Add'
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include('Search', 'AdWords')
  end
end
