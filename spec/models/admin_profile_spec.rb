require 'spec_helper'

describe AdminProfile do

  it "has a valid factory" do
    create(:admin_profile).should be_valid
  end

  it "is invalid without a first_name" do
    build(:admin_profile, first_name: nil).should_not be_valid
  end

  it "is invalid without a last_name" do
    build(:admin_profile, last_name: nil).should_not be_valid
  end

  it "returns a admin profile's full name as a string" do
    profile = create(:admin_profile, first_name: "John", last_name: "Doe")
    profile.full_name.should == "John Doe"
  end

  describe "filter last name by letter" do
    before :each do
      @smith    = create(:admin_profile, last_name: "Smith")
      @jones    = create(:admin_profile, last_name: "Jones")
      @johnson  = create(:admin_profile, last_name: "Johnson")
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        AdminProfile.by_letter("J").should == [@johnson, @jones]
      end
    end

    context "non-matching letters" do
      it "does not return contacts that don't start with the provided letter" do
        AdminProfile.by_letter("J").should_not include @smith
      end
    end
  end

end
