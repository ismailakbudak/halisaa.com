require 'spec_helper'

describe UserProfile do

  describe User do
    it { should belong_to(:user) }
    it 'user has one profile' do
      t = User.reflect_on_association(:user_profile)
      t.macro.should == :has_one
    end
    it 'user profile belongs to user' do
      t = UserProfile.reflect_on_association(:user)
      t.macro.should == :belongs_to
    end
  end

  it "has a valid factory" do
    create(:user_profile).should be_valid
  end

  it "is invalid without a first_name" do
    build(:user_profile, first_name: nil).should_not be_valid
  end

  it "is invalid without a last_name" do
    build(:user_profile, last_name: nil).should_not be_valid
  end

  it "returns a user profile's full name as a string" do
    @user_profile = create(:user_profile, first_name: "iso", last_name: "akbudak")
    @user_profile.full_name.should == "iso akbudak"
  end

  describe "filter last name by letter" do
    before :each do
      @iso    = create(:user_profile, first_name: "Iso", last_name: "Akbudak")
      @emine  = create(:user_profile, first_name: "Emine", last_name: "Ozkan")
      @semra  = create(:user_profile, first_name: "Semra", last_name: "Akbudak")
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        UserProfile.by_letter("A").should == [ @iso, @semra]
      end
    end

    context "non-matching letters" do
      it "does not return contacts that don't start with the provided letter" do
        UserProfile.by_letter("A").should_not include @emine
      end
    end
  end
end
