require 'rails_helper'

RSpec.feature "Visitor navigates to a product detail page", type: :feature, js: true do
  
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

  scenario "They click on the first product to see the details" do
    visit root_path
    first('.product').click_on "Details"
    
    expect(page).to have_css 'article.product-detail'
  end

end