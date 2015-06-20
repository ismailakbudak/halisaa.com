require 'spec_helper'

describe Admin do

  before :each do
    @admin = Admin.new email: 'test@test.com', password: '12341234'
    @admin.save
  end

  describe '#new' do
    it 'takes two parameters an returns  a Admin object' do
      @admin.should be_an_instance_of Admin
    end
  end

  describe '#email' do
    it 'returns the correct email' do
      @admin.email.should eql 'test@test.com'
    end
  end

  describe '#password' do
    it 'returns the correct password' do
      @admin.password.should eql '12341234'
    end
  end

end
