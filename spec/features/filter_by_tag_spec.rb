require 'spec_helper'

feature "Seeing tag-specific links" do

  before(:each) do
    visit_fill_1_tag
    visit_fill_1_other_tag
  end

  scenario 'on tag-specific pages' do
    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content('Google')
      expect(page).to have_content('Bubbles Site')
    end
  end
end
