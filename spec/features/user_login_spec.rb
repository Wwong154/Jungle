require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  
  before(:each) do
    @user = User.new(first_name: "Megazone", last_name: "23", email: "s@VmAil.com", password: "12345678", password_confirmation: "12345678")
    @user.save
  end

  scenario "User login, then logout" do
    visit root_path
    expect(page).to have_content('Login')
    find("a", :text => "Login").click
    sleep(1)
    find("input#email").set("s@VmAil.com")
    find("input#password").set("12345678")
    find('input[name="commit"]').click
    sleep(1)
    expect(page).to have_content('Logout')
    # commented out b/c it's for debugging only
    save_screenshot 'login.png'
    find("a", :text => "Logout").click
    sleep(1)
    save_screenshot 'logout.png'
  end
end
