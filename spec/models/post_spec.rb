require 'spec_helper'

describe Post do

	describe "validate the model" do

		context "valid records" do
			it "has a valid factory" do
				post = FactoryGirl.create(:post)
				expect(post).to be_valid
			end
		end

		context "invalid records" do
			it "is invalid without a category" do
				post = FactoryGirl.build(:post, category_id: nil)
				expect(post).not_to be_valid
			end

			it "is invalid without a user" do
				post = FactoryGirl.build(:post, user_id: nil)
				expect(post).not_to be_valid
			end
		end
	end

	describe "ensures instances methods are working" do
		before(:each) do
			@post = FactoryGirl.create(:post)
		end

		context "#has_profilepic?" do
			it "does not have any images" do
				expect(@post.has_profilepic?).to be == false
			end

			it "has an image but it has a mainpicindicator set to false" do
				# Create an image associated with Post that has mainpicindicator as false
				FactoryGirl.create(:image, imageable_id: @post.id, imageable_type: "Post", mainpicindicator: false)
				expect(@post.has_profilepic?).to be == false
			end

			it "has an image that has mainpicindicator set to true" do
				# Create an image associated with Post that has mainpicindicator as true
				FactoryGirl.create(:image, imageable_id: @post.id, imageable_type: "Post", mainpicindicator: true)
				expect(@post.has_profilepic?).to be == true
			end
		end

		context "#has_images?" do
			it "has no images" do
				expect(@post.has_images?).to be == false
			end

			it "has images" do
				FactoryGirl.create(:image, imageable_id: @post.id, imageable_type: "Post")
				expect(@post.has_images?).to be == true
			end
		end

		context "#has_project?" do
			it "has no project" do
				expect(@post.has_project?).to be == false
			end

			it "has a project, but it is not visible" do
				# Create project
				project = FactoryGirl.create(:project, visible: false)

				# Associate post with project
				@post.project_id = project.id
				@post.save

				expect(@post.has_project?).to be == false
			end

			it "has a project, and it is visible" do
				# Create project
				project = FactoryGirl.create(:project, visible: true)

				# Associate post with project
				@post.project_id = project.id
				@post.save

				expect(@post.has_project?).to be == true
			end
		end

		context "#like" do
			it "increments likes by 1" do
				@post.like == 1
			end
		end
	end

	describe "scopes" do

		# Clean up between tests
		before(:each) do
			Post.delete_all
			@post1 = FactoryGirl.create(:post, category_id: 1, visible: true)
			@post2 = FactoryGirl.create(:post, category_id: 1, visible: false)
			@post3 = FactoryGirl.create(:post, category_id: 2, visible: true)
		end

		context ".recent_posts" do

			it "returns a sorted array of posts that are visible" do
				expect(Post.recent_posts).to be == [@post3,@post1]
			end

			it "returns a sorted array of posts that are visible and belong to a category" do
				expect(Post.recent_posts(2)).to be == [@post3]
			end

			it "does not return a not visible post that belongs to a category" do
				expect(Post.recent_posts(1)).not_to be == [@post2,@post1]
			end

		end

		context ".manage_posts" do

			it "returns a sorted array of posts that are visible and not visible" do
				expect(Post.manage_posts).to be == [@post3,@post2,@post1]
			end

			it "returns a sorted array of posts that are visible and not visible and belong to a category" do
				expect(Post.manage_posts(1)).to be == [@post2,@post1]
			end

		end

	end

	# it "returns true if it has a project" do
	# 	post = FactoryGirl.create(:post, project_id: 1)
	# 	post.has_project? == true
	# end

	# it "returns false if it does not have a project" do
	# 	post = FactoryGirl.create(:post, project_id: nil)
	# 	post.has_project? == false
	# end
end