require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save with all four fields set' do
      @category = Category.new(name: 'testCat')
      @category.save!
      @product = Product.new(
        name:'testName',
        category_id: @category.id,
        quantity: 1,
        price: 420
      )
      @product.save!
    end

    it 'should fail to save with name set to nil' do
      @category = Category.new(name: 'testCat')
      @category.save!
      @product = Product.new(
        name: nil,
        category_id: @category.id,
        quantity: 1,
        price: 420
      )
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail to save with price set to nil' do
      @category = Category.new(name: 'testCat')
      @category.save!
      @product = Product.new(
        name: 'fancyname',
        category_id: @category.id,
        quantity: 1,
        price: nil
      )
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'should fail to save with price set to nil' do
      @category = Category.new(name: 'testCat')
      @category.save!
      @product = Product.new(
        name:'testName',
        category_id: @category.id,
        quantity: nil,
        price: 420
      )
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should fail to save with category set to nil' do
      @product = Product.new(
        name:'testName',
        category_id: nil,
        quantity: 1,
        price: 420
      )
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end

=begin 
describe '#id' do
  it 'should not exist for new records' do
    @widget = Widget.new
    expect(@widget.id).to be_nil
  end

  it 'should be auto-assigned by AR for saved records' do
    @widget = Widget.new
    # we use bang here b/c we want our spec to fail if save fails (due to validations)
    # we are not testing for successful save so we have to assume it will be successful
    @widget.save!

    expect(@widget.id).to be_present
  end
end
=end
