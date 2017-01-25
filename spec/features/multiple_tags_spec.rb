require 'spec_helper'

feature "Adding multiple tags" do
  scenario 'to a single link' do
    visit_fill_2_tags
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include('Search', 'AdWords')
  end
end
