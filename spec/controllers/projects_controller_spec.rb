require 'rails_helper'

describe ProjectsController do
	before(:each) do
		# Before filters on all methods
		expect(controller).to receive(:get_metadata)
	end

	describe 'GET #index' do
		before(:each) do
			Project.delete_all
		end

		it 'populates an array of projects by most recently visible published' do
			project1 = create(:visible_project)
			create(:image, imageable_id: project1.id, imageable_type: "Project", mainpicindicator: true)
			project2 = create(:visible_project)
			create(:image, imageable_id: project2.id, imageable_type: "Project", mainpicindicator: true)
			project3 = create(:invisible_project)
			create(:image, imageable_id: project3.id, imageable_type: "Project", mainpicindicator: true)

			array1 = [project2.to_param,project2.name,project2.images.mainpicture]
			array2 = [project1.to_param,project1.name,project1.images.mainpicture]

			get :index
			expect(assigns(:projects)).to eq([[array1,array2]])
		end

		it 'renders the :index template' do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		context 'valid project' do
			before(:each) do
				@project = create(:visible_project)
				get :show, id: @project
			end

			it 'assigns the requested project to @project' do
				expect(assigns(:project)).to eq(@project)
			end

			it 'returns all related posts' do
				post1 = create(:visible_post, project_id: @project.id)
				post2 = create(:visible_post, project_id: @project.id)

				expect(assigns(:posts)).to eq([post2,post1])
			end

			it 'renders the :show template' do
				expect(response).to render_template :show
			end
		end

		context 'invalid project' do
			before(:each) do
				@project = create(:invisible_project)
				get :show, id: @project
			end

			it 'redirects to root path' do
				expect(response).to redirect_to root_path
			end
		end
	end

	describe 'GET #new' do
		before(:each) do
			get :new
		end

		it 'assigns a new Project to @project' do		
			expect(assigns(:project)).to be_a_new(Project)
		end

		it 'renders the :new template' do
			expect(response).to render_template :new
		end
	end

	describe 'POST #create' do

		context 'with valid attributes' do

			it 'saves the new project in the database' do
				expect {
					post :create, project: attributes_for(:project)
				}.to change(Project, :count).by(1)
			end

			it 'redirects to projects#show' do
				post :create, project: attributes_for(:project)
				expect(response).to redirect_to new_project_path
			end

		end

	end

	describe 'GET #edit' do
		before(:each) do
			@project = create(:project)
			@image = create(:main_image, imageable_id: @project.id, imageable_type: "Project")
			get :edit, id: @project
		end

		it 'assigns the requested Project to @project' do
			expect(assigns(:project)).to eq @project
		end

		it 'assigns the mainpictureid of the @project to @mainpicture' do
			expect(assigns(:mainpicture)).to eq @image.id
		end

		it 'renders the :edit template' do
			expect(response).to render_template :edit
		end
	end

	describe 'PATCH #update' do
		before(:each) do
			@project = create(:project)
		end

		context 'with valid attributes' do

			it 'locates the requested @project' do
				patch :update, id: @project, project: attributes_for(:project)
				expect(assigns(:project)).to eq(@project)
			end

			it 'changes @project''s attributes' do
				patch :update, id: @project,
					project: attributes_for(:project, 
						description: 'Test change in description')
				@project.reload
				expect(@project.description).to eq('Test change in description')
			end

			it 'redirects to edit project path on success' do
				patch :update, id: @project, project: attributes_for(:project)
				expect(response).to redirect_to edit_project_path(@project.id)
			end
		end

	end

	describe 'DELETE #destroy' do
		before(:each) do
			@project = create(:project)
		end

		it 'deletes the project' do
			expect {
				delete :destroy, id: @project
			}.to change(Project,:count).by(-1)
		end

		it 'redirects to manageprojects path' do
			delete :destroy, id: @project
			expect(response).to redirect_to manageprojects_path
		end
	end

	describe 'GET #manage' do
		before(:each) do
			Project.delete_all
		end

		it 'populates an array of projects by most recently published' do
			project1 = create(:visible_project)
			project2 = create(:visible_project)
			project3 = create(:invisible_project)

			get :manage
			expect(assigns(:projects)).to eq ([project3,project2,project1])
		end

		it 'renders the :manage template' do
			get :manage
			expect(response).to render_template :manage
		end
	end
end