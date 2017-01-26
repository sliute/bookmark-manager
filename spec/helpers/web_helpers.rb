def visit_fill
  visit '/links/new'
  fill_in :title, with: 'Google'
  fill_in :url, with: 'http://www.google.com'
  click_button 'Add'
end

def visit_fill_1_tag
  visit '/links/new'
  fill_in :title, with: 'Google'
  fill_in :url, with: 'http://www.google.com'
  fill_in :tag, with: 'Search Engine'
  click_button 'Add'
end

def visit_fill_1_other_tag
  visit '/links/new'
  fill_in :title, with: 'Bubbles Site'
  fill_in :url, with: 'http://www.google-bubbles.com'
  fill_in :tag, with: 'bubbles'
  click_button 'Add'
end

def visit_fill_2_tags
  visit '/links/new'
  fill_in :title, with: 'Google'
  fill_in :url, with: 'http://www.google.com'
  fill_in :tag, with: 'Search, AdWords'
  click_button 'Add'
end

def sign_up
  visit '/users/new'
  fill_in :email, with: 'johndoe@internet.com'
  fill_in :password, with: 'password'
  click_button 'Sign up'
end
