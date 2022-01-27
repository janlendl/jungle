require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be valid with matching password' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "matchy", password_confirmation: "matchy")
      expect(@user).to be_valid
    end

    it 'should be invalid if the password does not match' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "12345678", password_confirmation: "1333")
      expect(@user).to_not be_valid
    end

    it 'should be invalid if the password is blank' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: nil, password_confirmation: "133322")
      expect(@user).to_not be_valid
    end

    it 'should be invalid if the password_confirmation is blank' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "123456", password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'should meet the password minimum length of 6' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "123456", password_confirmation: "123456")
      expect(@user).to be_valid
    end

    it 'should be invalid if name is blank' do
      @user = User.new(name: nil, email: "john@wick.com", password: "123", password_confirmation: "123")
      expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should be invalid if email is blank' do
      @user = User.new(name: "Mr. Anderson", email: nil, password: "123", password_confirmation: "123")
      expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    # it 'should be invalid if email already exists' do
    #   user.email = "this@myemail.com"

    #   @user = User.new(name: "Mr. Anderson", email: "this@myemail.com", password: "123456", password_confirmation: "123456")
    #   expect(@user).to be_valid
    # end

  end

end
