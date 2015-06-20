require 'spec_helper'

describe User do

  before :each do
    @user_factory = create(:user)
    @user = User.new email: 'test@test.com', password: '12341234', name: 'test'
    @user.save
  end

  describe '#new' do
    it 'takes two parameters an returns  a User object' do
      @user.should be_an_instance_of User
    end
    it 'takes two parameters an returns  a User object' do
      @user_factory.should be_an_instance_of User
    end
  end

  describe '#email' do
    it 'returns the correct email' do
      @user.email.should eql 'test@test.com'
    end
    it 'returns the correct email' do
      @user_factory.email.should eql 'factory@test.com'
    end
  end

  describe '#password' do
    it 'returns the correct password' do
      @user.password.should eql '12341234'
    end
    it 'returns the correct password' do
      @user_factory.password.should eql '12341234'
    end
  end

  describe '#name' do
    it 'returns the correct name' do
      @user.name.should eql 'test'
    end
    it 'returns the correct name' do
      @user_factory.name.should eql 'factory'
    end
  end

end

