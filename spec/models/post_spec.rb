require 'spec_helper'
require 'rails_helper'

describe Post do
  describe 'validate the model' do
    context 'valid records' do
      it 'has a valid factory' do
        post = create(:post)
        expect(post).to be_valid
      end
    end

    context 'invalid records' do
      it 'is invalid without a category' do
        post = build(:post, category_id: nil)
        expect(post).not_to be_valid
      end

      it 'is invalid without a user' do
        post = build(:post, user_id: nil)
        expect(post).not_to be_valid
      end
    end
  end

  describe 'ensures instances methods are working' do
    before(:each) do
      @post = create(:post)
    end

    context '#has_profilepic?' do
      it 'does not have any images' do
        expect(@post.has_profilepic?).to eq false
      end

      it 'has an image but it has a mainpicindicator set to false' do
        # Create an image associated with Post that has mainpicindicator as false
        create(:non_main_image, imageable_id: @post.id, imageable_type: 'Post')
        expect(@post.has_profilepic?).to eq false
      end

      it 'has an image that has mainpicindicator set to true' do
        # Create an image associated with Post that has mainpicindicator as true
        create(:main_image, imageable_id: @post.id, imageable_type: 'Post')
        expect(@post.has_profilepic?).to eq true
      end
    end

    context '#has_images?' do
      it 'has no images' do
        expect(@post.has_images?).to eq false
      end

      it 'has images' do
        create(:image, imageable_id: @post.id, imageable_type: 'Post')
        expect(@post.has_images?).to eq true
      end
    end

    context '#has_project?' do
      it 'has no project' do
        expect(@post.has_project?).to eq false
      end

      it 'has a project, but it is not visible' do
        # Create project
        project = create(:invisible_project)

        # Associate post with project
        @post.project_id = project.id
        @post.save

        expect(@post.has_project?).to eq false
      end

      it 'has a project, and it is visible' do
        # Create project
        project = create(:visible_project)

        # Associate post with project
        @post.project_id = project.id
        @post.save

        expect(@post.has_project?).to eq true
      end
    end

    context '#like' do
      it 'increments likes by 1' do
        originalcount = @post.likes
        @post.like
        expect(@post.likes).to eq (originalcount + 1)
      end
    end
  end

  describe 'scopes' do
    # Clean up between tests
    before(:each) do
      Post.delete_all
      @post1 = create(:visible_post, category_id: 1)
      @post2 = create(:invisible_post, category_id: 1)
      @post3 = create(:visible_post, category_id: 2)
    end

    context '.recent_posts' do
      it 'returns a sorted array of posts that are visible' do
        expect(Post.recent_posts).to eq [@post3, @post1]
      end

      it 'returns a sorted array of posts that are visible and belong to a category' do
        expect(Post.recent_posts(2)).to eq [@post3]
      end

      it 'does not return a not visible post that belongs to a category' do
        expect(Post.recent_posts(1)).not_to eq [@post2, @post1]
      end
    end

    context '.manage_posts' do
      it 'returns a sorted array of posts that are visible and not visible' do
        expect(Post.manage_posts).to eq [@post3, @post2, @post1]
      end

      it 'returns a sorted array of posts that are visible and not visible and belong to a category' do
        expect(Post.manage_posts(1)).to eq [@post2, @post1]
      end
    end
  end
end
