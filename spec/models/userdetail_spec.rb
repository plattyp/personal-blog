require 'spec_helper'
require 'rails_helper'

describe Userdetail do
  describe 'ensures instance methods are working' do
    before(:each) do
      user = create(:user)
      @userdetail = create(:userdetail, user_id: user.id)
    end

    context '#profile_pic' do
      it 'does not have a profile picture' do
        expect(@userdetail.profile_pic).to eq nil
      end

      it 'has a profile picture' do
        # Create images associated with Userdetail
        image = create(:image, imageable_id: @userdetail.id, imageable_type: 'Userdetail')
        create(:image, imageable_id: @userdetail.id, imageable_type: 'Userdetail')

        expect(@userdetail.profile_pic).to eq image.id
      end
    end

    context '#has_profilepic?' do
      it 'does not have a profile picture' do
        expect(@userdetail.has_profilepic?).to eq false
      end

      it 'has a profile picture' do
        # Create images associated with Userdetail
        create(:image, imageable_id: @userdetail.id, imageable_type: 'Userdetail')

        expect(@userdetail.has_profilepic?).to eq true
      end
    end

    context '#has_github?' do
      it 'does not have a github_url' do
        user = create(:user)
        userdetail = create(:userdetail, user_id: user.id, github_url: nil)

        expect(userdetail.has_github?).to eq false
      end

      it 'has a github_url' do
        expect(@userdetail.has_github?).to eq true
      end
    end

    context '#has_linkedin?' do
      it 'does not have a linkedin_url' do
        user = create(:user)
        userdetail = create(:userdetail, user_id: user.id, linkedin_url: nil)

        expect(userdetail.has_linkedin?).to eq false
      end

      it 'has a linkedin_url' do
        expect(@userdetail.has_linkedin?).to eq true
      end
    end

    context '#replace_profile_pic' do
      before(:each) do
        @originalimage = create(:image, imageable_id: @userdetail.id, imageable_type: 'Userdetail')
      end

      it 'does not need to replace the profile picture' do
        @userdetail.replace_profile_pic
        expect(@userdetail.profile_pic).to eq @originalimage.id
        expect(@userdetail.images.count).to eq 1
      end

      it 'replaces your profile picture' do
        replacement = create(:image, imageable_id: @userdetail.id, imageable_type: 'Userdetail')
        @userdetail.replace_profile_pic
        expect(@userdetail.profile_pic).to eq replacement.id
        expect(@userdetail.images.count).to eq 1
      end
    end
  end
end
