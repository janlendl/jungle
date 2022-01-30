require 'rails_helper'

RSpec.feature "Visitor can add product to cart", type: :feature, js: true  do
  
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can add to product to cart" do
  
    # ACT
    visit root_path
    first('.product').click_on('Add')

    #DEBUG / VERIFY WITH SLEEP TIMER
    sleep(2)
    save_screenshot 'test_add_to_cart.png'

    expect(page).to have_content('My Cart (1)')
  end
end
