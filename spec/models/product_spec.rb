require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    it 'should create a new product when all fields are present' do
      @category = Category.new(name: "My Category")
      @category.save!
      @product = Product.new(name: "My Product", price: 500, quantity: 5, category: @category)
      @product.save!

      expect(@product.id).to be_present
    end

    it 'should not save if the name is empty' do
      @category = Category.new(name: "My Category")
      @category.save!
      @product = Product.new(name: nil, price: 100, quantity: 2, category: @category)
 
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
