require 'spec_helper'

describe User do

	describe "validate the model" do

		context "valid signup" do
			it "does have a signup code" do
				user = FactoryGirl.build(:user,signupcode: ENV["SIGNUPCODE"])
				expect(user).to be_valid
			end
		end

		context "invalid signup" do
			it "does not have signup code" do
				user = FactoryGirl.build(:user,signupcode: nil)
				expect(user).not_to be_valid
			end
		end

	end

	describe "ensures instance methods are working" do
		before(:each) do
			@user = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
		end

		context "#has_details?" do

			it "does not have any details" do
				expect(@user.has_details?).to be == false
			end

			it "does have details" do
				FactoryGirl.create(:userdetail, user_id: @user.id)
				expect(@user.has_details?).to be == true
			end

		end
	end

	describe "ensures class methods are working" do
		before(:each) do
			User.destroy_all
			@user1 = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
			@user2 = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
		end

		context ".selectusers" do
			it "returns an array of names and ids" do
				expect(User.selectusers).to be == [[@user1.name,@user1.id],[@user2.name,@user2.id]]
			end
		end
	end

end
