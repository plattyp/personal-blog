require 'spec_helper'

describe Project do

	describe "validate the model" do

		context "valid records" do
			it "has a valid factory" do
				project = FactoryGirl.create(:project)
				expect(project).to be_valid
			end
		end

	end

	describe "ensure instance methods are working" do
		before(:each) do
			@project = FactoryGirl.create(:project)
		end

		context "#has_images?" do

			it "does not have any images" do
				expect(@project.has_images?).to be == false
			end

			it "does have images" do
				FactoryGirl.create(:image, imageable_id: @project.id, imageable_type: "Project")
				expect(@project.has_images?).to be == true
			end

		end

		context "#has_github?" do

			it "does not have a github_url" do
				project = FactoryGirl.create(:project, github_url: nil)
				expect(project.has_github?).to be == false
			end

			it "does have a github_url" do
				# Project should have a github_url from the Factory
				expect(@project.has_github?).to be == true
			end

		end

		context "#has_appstore?" do

			it "does not have an appstore_url" do
				project = FactoryGirl.create(:project, appstore_url: nil)
				expect(project.has_appstore?).to be == false
			end

			it "does have an appstore_url" do
				# Project should have a url from the Factory
				expect(@project.has_appstore?).to be == true
			end

		end

		context "#has_website?" do

			it "does not have an url" do
				project = FactoryGirl.create(:project, url: nil)
				expect(project.has_website?).to be == false
			end

			it "does have an url" do
				# Project should have a url from the Factory
				expect(@project.has_website?).to be == true
			end
			
		end
	end

	describe "ensure class methods are working" do
		before(:each) do
			Project.delete_all
			@project1 = FactoryGirl.create(:project)
			@project2 = FactoryGirl.create(:project)
		end

		context ".selectprojects" do

			it "returns an array of ids and names" do
				expect(Project.selectprojects).to be == [[@project1.name,@project1.id],[@project2.name,@project2.id]]
			end

		end

		context ".grid" do
			before(:each) do
				# Add some additional projets for the test
				@project3 = FactoryGirl.create(:project)
				@project4 = FactoryGirl.create(:project)
				@project5 = FactoryGirl.create(:project)

				# Create images associated with these projects
				Project.all.each do |p|
					FactoryGirl.create(:image, imageable_id: p.id, imageable_type: "Project", mainpicindicator: true)
				end
			end
			
			it "returns a grid by 3s of projects with an image" do
				expect(Project.grid).to be == [
					[[@project5.id,@project5.name,@project5.images.mainpicture],[@project4.id,@project4.name,@project4.images.mainpicture],[@project3.id,@project3.name,@project3.images.mainpicture]],
					[[@project2.id,@project2.name,@project2.images.mainpicture],[@project1.id,@project1.name,@project1.images.mainpicture]]]
			end
		end
	end
end