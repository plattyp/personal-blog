require 'rails_helper'

describe PostsController do
	before(:each) do
		# Before filters on all methods
		expect(controller).to receive(:get_metadata)
	end
end