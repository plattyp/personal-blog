require 'spec_helper'

describe Userdetail do

	describe "ensures instance methods are working" do
		before(:each) do
			user = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
			@userdetail = FactoryGirl.create(:userdetail, user_id: user.id)
		end

		context "#profile_pic" do

			it "does not have a profile picture" do
				expect(@userdetail.profile_pic).to be == nil
			end

			it "has a profile picture" do
				# Create images associated with Userdetail
				image = FactoryGirl.create(:image, imageable_id: @userdetail.id, imageable_type: "Userdetail")
				image2 = FactoryGirl.create(:image, imageable_id: @userdetail.id, imageable_type: "Userdetail")
				
				expect(@userdetail.profile_pic).to be == image.id
			end
		end

		context "#has_profilepic?" do

			it "does not have a profile picture" do
				expect(@userdetail.has_profilepic?).to be == false
			end

			it "has a profile picture" do
				# Create images associated with Userdetail
				FactoryGirl.create(:image, imageable_id: @userdetail.id, imageable_type: "Userdetail")

				expect(@userdetail.has_profilepic?).to be == true
			end
		end

		context "#has_github?" do

			it "does not have a github_url" do
				user = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
				userdetail = FactoryGirl.create(:userdetail, user_id: user.id, github_url: nil)

				expect(userdetail.has_github?).to be == false
			end

			it "has a github_url" do
				expect(@userdetail.has_github?).to be == true
			end

		end

		context "#has_linkedin?" do

			it "does not have a linkedin_url" do
				user = FactoryGirl.create(:user,signupcode: ENV["SIGNUPCODE"])
				userdetail = FactoryGirl.create(:userdetail, user_id: user.id, linkedin_url: nil)

				expect(userdetail.has_linkedin?).to be == false
			end

			it "has a linkedin_url" do
				expect(@userdetail.has_linkedin?).to be == true
			end

		end

		context "#replace_profile_pic" do
			before(:each) do
				@originalimage = FactoryGirl.create(:image, imageable_id: @userdetail.id, imageable_type: "Userdetail")
			end

			it "does not need to replace the profile picture" do
				@userdetail.replace_profile_pic
				expect(@userdetail.profile_pic).to be == @originalimage.id
				expect(@userdetail.images.count).to be == 1
			end

			it "replaces your profile picture" do
				replacement = FactoryGirl.create(:image, imageable_id: @userdetail.id, imageable_type: "Userdetail")
				@userdetail.replace_profile_pic
				expect(@userdetail.profile_pic).to be == replacement.id
				expect(@userdetail.images.count).to be == 1
			end
		end
	end

end