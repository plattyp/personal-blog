#require 'spec_helper'
require 'rails_helper'

describe PostsController do
	
	describe 'GET #index' do
	end

	describe 'GET #show' do
		before(:each) do
			expect(controller).to receive(:get_metadata)
			expect(controller).to receive(:validate_post)
		end

		it "assigns the requested post to @post" do
			post = create(:post)
			get :show, id: post
			expect(assigns(:post)).to eq post
		end
	end

	describe 'GET #new' do
	end

	describe 'GET #edit' do
	end

	describe 'PATCH #update' do
	end

	describe 'DELETE #destroy' do
	end

end