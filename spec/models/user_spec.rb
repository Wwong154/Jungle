require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.new(first_name: "Megazone", last_name: "23", email: "s@VmAil.com", password: "12345678", password_confirmation: "12345678")
    @user.save
  end

  it 'can make new user with valid info' do
    a_user = User.new(first_name: "Megazone", last_name:"23", email: "Shogo@vmail.com", password: "12345678", password_confirmation: "12345678")
    expect(a_user).to be_valid
  end
  it 'return error with no first_name' do
    a_user = User.new(first_name: nil, last_name:"23", email: "Shogo@vmail.com", password: "12345678", password_confirmation: "12345678")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["First name can't be blank"]
  end
  it 'return error with no last_name' do
    a_user = User.new(first_name: "Megazone", last_name: nil, email: "Shogo@vmail.com", password: "12345678", password_confirmation: "12345678")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Last name can't be blank"]
  end
  it 'return error with no email' do
    a_user = User.new(first_name: "Megazone", last_name: "23", email: nil, password: "12345678", password_confirmation: "12345678")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Email is invalid"]
  end
  it 'return error with invalid email' do
    a_user = User.new(first_name: "Megazone", last_name: "23", email: "My name is Jeff", password: "12345678", password_confirmation: "12345678")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Email is invalid"]
  end
  it 'return error with duplicated email(non case sensitive)' do
    a_user = User.new(first_name: "Megazone", last_name: "23", email: "S@VmaIl.cOm", password: "12345678", password_confirmation: "12345678")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Email has already been taken"]
  end
  it 'return error with different password' do
    a_user = User.new(first_name: "Megazone", last_name:"23", email: "Shogo@vmail.com", password: "12345678", password_confirmation: "1234568")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
  end
  it 'return error with short password' do
    a_user = User.new(first_name: "Megazone", last_name:"23", email: "Shogo@vmail.com", password: "123456", password_confirmation: "123456")
    expect(a_user).to_not be_valid
    expect(a_user.errors.full_messages).to eq ["Password is too short (minimum is 8 characters)"]
  end

  describe '.authenticate_with_credentials' do
    it 'return user_id if email and password is valid' do
      user = User.authenticate_with_credentials("  s@vmail.com", 12345678)
      expect(user).to_not be_nil
    end
    it 'return user_id if email and password is valid, even with extra space' do
      user = User.authenticate_with_credentials("  s@vmail.com   ", 12345678)
      expect(user).to_not be_nil
    end
    it 'return user_id if email and password is valid, even with extra space and different case' do
      user = User.authenticate_with_credentials("  S@vmail.com   ", 12345678)
      expect(user).to_not be_nil
    end

    it 'return nil if email is invalid' do
      user = User.authenticate_with_credentials("saaa@vmail.com", 12345678)
      expect(user).to be_nil
    end
    it 'return nil if password is invalid' do
      user = User.authenticate_with_credentials("s@vmail.com", "12345fsaf68")
      expect(user).to be_nil
    end
  end
end
