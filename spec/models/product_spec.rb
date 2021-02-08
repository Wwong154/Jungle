require 'rails_helper'

describe Product, type: :model do

  before(:each) do
    @cate = Category.new(name: "misc.")
    @cate.save
  end

  it 'can save new product with valid info' do
    a_pro = Product.new(name: "robot",price: 1000, quantity: 20, category: @cate)
    expect(a_pro).to be_valid
  end
  it 'return error with no name' do
    a_pro = Product.new(name: nil,price: 1000, quantity: 20, category: @cate)
    expect(a_pro).to_not be_valid
    expect(a_pro.errors.full_messages).to eq ["Name can't be blank"]
  end
  it 'return error with no price' do
    a_pro = Product.new(name: "robot",price: nil, quantity: 20, category: @cate)
    expect(a_pro).to_not be_valid
    expect(a_pro.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
  end
  it 'return error with no quantity' do
    a_pro = Product.new(name: "robot",price: 1000, quantity: nil, category: @cate)
    expect(a_pro).to_not be_valid
    expect(a_pro.errors.full_messages).to eq ["Quantity can't be blank"]
  end
  it 'return name error with no category' do
    a_pro = Product.new(name: "robot",price: 1000, quantity: 20, category: nil)
    expect(a_pro).to_not be_valid
    expect(a_pro.errors.full_messages).to eq ["Category can't be blank"]
  end
end

