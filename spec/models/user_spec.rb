require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 

    it 'should be valid for matching passwords' do
      @user = User.new(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(@user).to be_valid
    end

    it 'should fail on password mismatch' do
      @user = User.new(name: "user", email: "user@example.com", password:"password", password_confirmation:"pssaword")
      expect(@user).to_not be_valid
    end

    it 'should be valid for unique emails' do 
      @user1 = User.new(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      @user2 = User.new(name: "user", email: "another_user@example.com", password:"password", password_confirmation:"password")
      expect(@user1).to be_valid
      expect(@user2).to be_valid
    end

    it 'should fail for repeated emails, case-insensitive' do 
      @user1 = User.new(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(@user1).to be_valid
      @user1.save!
      @user2 = User.new(name: "user", email: "USER@example.com", password:"password", password_confirmation:"password")
      expect(@user2).to_not be_valid
    end

    it 'should fail on a missing name or email' do
      @user1 = User.new(name: nil, email: "user@example.com", password:"password", password_confirmation:"password")
      expect(@user1).to_not be_valid
      @user2 = User.new(name: "user", email: nil, password:"password", password_confirmation:"password")
      expect(@user2).to_not be_valid
    end

    it 'should fail on the password shorter than 6 characters' do
      @user = User.new(name: "user", email: "user@example.com", password:"pass", password_confirmation:"pass")
      expect(@user).to_not be_valid
    end

  end
  
  describe '.authenticate_with_credentials' do

    it 'should log the user in normally' do
      @user = User.create(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("user@example.com", "password")).to eq(@user)
    end

    it 'should not log in on password mismatch' do
      @user = User.create(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("user@example.com", "pssaword")).to eq(nil)
    end

    it 'should trim whitespace from the email' do
      @user = User.create(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials(" user@example.com ", "password")).to eq(@user)
    end

    it 'should accept email case-insensitive' do
      @user = User.create(name: "user", email: "user@example.com", password:"password", password_confirmation:"password")
      expect(User.authenticate_with_credentials("USER@EXAMPLE.com", "password")).to eq(@user)
    end

  end
end
