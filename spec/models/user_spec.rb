require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "validates :email, presence: true" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: nil, password: '123456', password_confirmation: '123456')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it "validates :first_name, presence: true" do
      user = User.new(first_name: nil, last_name: 'Doe', email: 'jdoe@gmail.com', password: '123456', password_confirmation: '123456')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "validates :last_name, presence: true" do
      user = User.new(first_name: 'John', last_name: nil, email: 'jdoe@gmail.com', password: '123456', password_confirmation: '123456')

      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it 'validates :password and :password_confirmation, should be the same' do
      user = User.new(first_name: "John", last_name: "Doe", email: "jdoe@email.com", password: "123456", password_confirmation: "1234567")
      expect(user).to_not be_valid
    end


    it 'email must be unique' do
      user1 = User.create(first_name: "John", last_name: "Doe", email: "jdoe@gmail.com", password: "123456", password_confirmation: "123456")
      user2 = User.create(first_name: "John", last_name: "Doe", email: "jdoe@gmail.com", password: "123456", password_confirmation: "123456")
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to eq [
        "Email has already been taken"
      ]
    end
  end

  describe '.authenticate_with_credentials' do
    before(:all) do
      @user = User.create(first_name: "John", last_name: "Doe", email: "jdoe@gmail.com", password: "123456", password_confirmation: "123456")
    end

    it 'should log in user with correct information' do
      user = User.authenticate_with_credentials("jdoe@gmail.com", "123456")
      expect(user).to be_a User
    end

  end

end