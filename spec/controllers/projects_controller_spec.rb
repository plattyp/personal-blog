require 'rails_helper'

describe PostsController do
	before(:each) do
		# Before filters on all methods
		expect(controller).to receive(:get_metadata)
	end

	describe 'GET #index' do

	end

	describe 'GET #show' do
	end

	describe 'GET #new' do
	end

	describe 'POST #create' do
	end

	describe 'GET #edit' do
	end

	describe 'PATCH #update' do
	end

	describe 'DELETE #destroy' do
	end

	describe 'GET #manage' do
	end
end