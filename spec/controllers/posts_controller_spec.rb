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
        create(:post, category_id: 2, visible: true)
        post3 = create(:post, category_id: 1, visible: true)

        get :index, category_id: 1
        expect(assigns(:posts)).to eq [post3, post1]
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
        create(:post, category_id: 1, visible: false)

        get :index
        expect(assigns(:posts)).to eq [post2, post1]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'valid post' do
      before(:each) do
        @post = create(:visible_post)
        get :show, id: @post
      end

      it 'assigns the requested post to @post' do
        expect(assigns(:post)).to eq @post
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    context 'invalid post' do
      before(:each) do
        @post = create(:invisible_post)
        get :show, id: @post
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
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
      # Uses the controller_helper sign_un method to authenticate the route
      user = create(:user, signupcode: ENV['SIGNUPCODE'])
      sign_in user
    end

    context 'with valid attributes' do
      it 'saves the new post in the database' do
        expect do
          post :create, post: attributes_for(:post)
        end.to change(Post, :count).by(1)
      end

      it 'redirects to posts#show' do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to post_path(assigns[:post].id)
      end
    end

    context 'with invalid attributes' do
      it 'is unable to save the new post in the database' do
        expect do
          post :create, post: attributes_for(:post,
                                             category_id: nil)
        end.to change(Post, :count).by(0)
      end

      it 'redirects to posts#new' do
        post :create, post: attributes_for(:post,
                                           category_id: nil)
        expect(response).to redirect_to new_post_path
      end
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
    before(:each) do
      @post = create(:post)
    end

    context 'with valid attributes' do
      it 'locates the requested @post' do
        patch :update, id: @post, post: attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it 'changes @post''s attributes' do
        patch :update, id: @post,
                       post: attributes_for(:post,
                                            content: 'Test change in content',
                                            project_id: 3)
        @post.reload
        expect(@post.content).to eq('Test change in content')
        expect(@post.project_id).to eq(3)
      end

      it 'redirects to the edit page on success' do
        patch :update, id: @post, post: attributes_for(:post)
        expect(response).to redirect_to edit_post_path(@post.id)
      end
    end

    context 'with invalid attributes' do
      it 'does not change the @post''s attributes' do
        name = @post.name
        content = @post.content

        patch :update, id: @post,
                       post: attributes_for(:post,
                                            content: nil,
                                            name: nil)
        @post.reload
        expect(@post.content).to eq(content)
        expect(@post.name).to eq(name)
      end

      it 'redirects back to edit page on failure' do
        patch :update, id: @post,
                       post: attributes_for(:invalid_post)
        expect(response).to redirect_to edit_post_path(@post.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @post = create(:post)
    end

    it 'deletes the post' do
      expect do
        delete :destroy, id: @post
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to manageposts path' do
      delete :destroy, id: @post
      expect(response).to redirect_to manageposts_path
    end
  end

  describe 'GET #manage' do
    before(:each) do
      Post.delete_all
    end

    it 'populates an array of posts with a category_id by most recently published posts' do
      post1 = create(:post, category_id: 1, visible: true)
      create(:post, category_id: 2, visible: true)
      post3 = create(:post, category_id: 1, visible: false)

      get :manage, category_id: 1
      expect(assigns(:posts)).to eq [post3, post1]
    end

    it 'renders the :manage template' do
      get :manage, category_id: 1
      expect(response).to render_template :manage
    end
  end

  describe 'PATCH #like' do
    before(:each) do
      request.env['HTTP_REFERER'] = 'http://localhost.com:3000'
      user = create(:user)
      @post = create(:post, user_id: user.id)
    end

    it 'locates the requested @post' do
      patch :like, id: @post, post: attributes_for(:post)
      expect(assigns(:post)).to eq(@post)
    end

    it 'increments a posts likes by 1' do
      likes = @post.likes
      patch :like, id: @post
      expect(@post.reload.likes).to eq(likes + 1)
    end

    it 'sends email to user' do
      patch :like, id: @post
      expect { UserMessage.send_user_like(@post).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'redirects back to the previous page' do
      patch :like, id: @post
      expect(response).to redirect_to 'http://localhost.com:3000'
    end
  end
end
