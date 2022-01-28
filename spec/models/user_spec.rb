require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be valid with matching password' do
      @user = User.new(name: "John Wick", email: "john1@wick.com", password: "matchy", password_confirmation: "matchy")
      expect(@user).to be_valid
    end

    it 'should be invalid if the password does not match' do
      @user = User.new(name: "John Wick", email: "john2@wick.com", password: "12345678", password_confirmation: "1333")
      expect(@user).to_not be_valid
    end

    it 'should be invalid if the password is blank' do
      @user = User.new(name: "John Wick", email: "john3@wick.com", password: nil, password_confirmation: "133322")
      expect(@user).to_not be_valid
    end

    it 'should be invalid if the password_confirmation is blank' do
      @user = User.new(name: "John Wick", email: "john4@wick.com", password: "123456", password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it 'should meet the password minimum length of 6' do
      @user = User.new(name: "John Wick", email: "john5@wick.com", password: "123456", password_confirmation: "123456")
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

    it 'should be invalid if email already exists and ignores case sensitivity' do
      # creates the first user to trigger the check when a 2nd user is created with the same email
      @user = User.new(name: "Mr. Mime", email: "matrix@myemail.com", password: "123456", password_confirmation: "123456")
      @user.save!

      @user = User.new(name: "Mr. Anderson", email: "MATRIX@MYEMAIL.COM", password: "123456", password_confirmation: "123456")
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should return a truthy value if user login is correct' do
      @user = User.new(name: "Mr. Mime", email: "jan@mailme.com", password: "123456", password_confirmation: "123456")
      @user.save!

      @new_session = @user.authenticate_with_credentials("jan@mailme.com", "123456")
      expect(@new_session).to be_truthy
    end
  end

end
