require 'rails_helper'

describe PostsController do
	before(:each) do
		# Before filters on all methods
		expect(controller).to receive(:get_metadata)
	end
	
	describe 'GET #index' do
		before(:each) do
			Post.delete_all
		end

		context 'with params[:category_id]' do
			
			it 'populates an array of posts with a category_id by most recently published visible posts' do
				post1 = create(:post, category_id: 1, visible: true)
				post2 = create(:post, category_id: 2, visible: true)
				post3 = create(:post, category_id: 1, visible: true)

				get :index, category_id: 1
				expect(assigns(:posts)).to eq ([post3,post1])
			end

			it 'renders the :index template' do
				get :index, category_id: 1
				expect(response).to render_template :index
			end

		end

		context 'without params[:category_id]' do
			
			it 'populates an array of posts by most recently published visible posts' do
				post1 = create(:post, category_id: 1, visible: true)
				post2 = create(:post, category_id: 2, visible: true)
				post3 = create(:post, category_id: 1, visible: false)

				get :index
				expect(assigns(:posts)).to eq ([post2,post1])
			end

			it 'renders the :index template' do
				get :index
				expect(response).to render_template :index
			end

		end

	end

	describe 'GET #show' do
		before(:each) do
			expect(controller).to receive(:validate_post)
			@post = create(:post)
			get :show, id: @post
		end

		it 'assigns the requested post to @post' do
			expect(assigns(:post)).to eq @post
		end

		it 'renders the :show template' do
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		before(:each) do
			expect(controller).to receive(:get_selectors)
			get :new
		end

		it 'assigns a new Post to @post' do		
			expect(assigns(:post)).to be_a_new(Post)
		end

		it 'renders the :new template' do
			expect(response).to render_template :new
		end

	end

	describe 'POST #create' do
		before(:each) do
			#login_user
		end

		context 'with valid attributes' do

			it 'saves the new post in the database' do
				expect {
					post :create, post: attributes_for(:post)
				}.to change(Post, :count).by(1)
			end

			it 'redirects to posts#show' do
				post :create, post: attributes_for(:post)
				expect(response).to redirect_to post_path(assigns[:post])
			end

		end

		context 'with invalid attributes' do
		end

	end

	describe 'GET #edit' do
		before(:each) do
			expect(controller).to receive(:get_selectors)
			@post = create(:post)
			get :edit, id: @post
		end

		it 'assigns the requested post to @post' do
			expect(assigns(:post)).to eq @post
		end

		it 'renders the :edit template' do
			expect(response).to render_template :edit
		end

	end

	describe 'PATCH #update' do
	end

	describe 'DELETE #destroy' do
	end

end