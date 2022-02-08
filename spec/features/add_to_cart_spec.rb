require 'rails_helper'

RSpec.feature "Visitor adds product to cart in homepage", type: :feature, js: true do

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

    # it block
    scenario "They can click Add and cart will show up as 'Cart(1)'" do
      # ACT
      visit root_path
      save_screenshot
      expect(page).to have_text 'My Cart (0)'
      click_link_or_button('Add', match: :first)
  
      # DEBUG
      save_screenshot
  
      #VERIFY
      expect(page).to have_text 'My Cart (1)'
    end

end