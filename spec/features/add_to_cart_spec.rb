require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Check cart count, add product and check again" do
    visit :products
    expect(page).to have_content('My Cart (0)')
    first('footer > form').click
    sleep(1)
    expect(page).to have_content('My Cart (1)')
    # commented out b/c it's for debugging only
    # save_screenshot 'add_cart.png'
  end
end
