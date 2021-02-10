require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "Click on first product Detail link" do
    visit :products
    first('footer > a').click
    sleep(1)
    # commented out b/c it's for debugging only
    save_screenshot 'pro_detail.png'
  end

  scenario "Click on first product header" do
    visit :products
    first('article > header').click
    sleep(1)
    # commented out b/c it's for debugging only
    save_screenshot 'pro_detail2.png'
  end
end
