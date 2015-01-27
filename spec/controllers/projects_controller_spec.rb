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
	end

	describe 'GET #show' do
		context 'valid project' do
			before(:each) do
				@project = create(:visible_project)
				get :show, id: @project
			end

			it 'assigns the requeste project to @project' do
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
		end
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