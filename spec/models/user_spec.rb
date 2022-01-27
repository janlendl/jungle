require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be valid with matching password' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "123", password_confirmation: "123")
      expect(@user.password).to match(@user.password_confirmation)
    end

    it 'should be invalid if the password does not match' do
      @user = User.new(name: "John Wick", email: "john@wick.com", password: "123", password_confirmation: "1333")
      expect(@user.password).to_not match(@user.password_confirmation)
    end

    it 'should be invalid if name is blank' do
      @user = User.new(name: nil, email: "john@wick.com", password: "123", password_confirmation: "123")
      expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should be invalid if email is blank' do
      @user = User.new(name: "Mr. Anderson", email: nil, password: "123", password_confirmation: "123")
      expect { @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


end
