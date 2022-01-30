require 'rails_helper'

RSpec.feature "Visitor goes to the product detail page", type: :feature, js: true  do
  
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

  scenario "They see the product details" do
  
    # ACT
    visit root_path
    first('.product > header').click

    #DEBUG / VERIFY WITH SLEEP TIMER
    sleep(2)
    save_screenshot 'test_product_details.png'

    expect(page).to have_css 'article.product-detail'
  end
end
