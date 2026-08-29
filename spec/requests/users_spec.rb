require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'SUITE /api/v1/users' do

    let(:data_create) { attributes_for(:users, name: 'Usuario create') }
    let!(:data_edit) { create(:users, name: 'Usuario edit old', active: 1) }
    let!(:data_search) { create(:users, name: 'Usuario search', active: 1) }
    let!(:data_delete) { create(:users, name: 'Usuario delete', active: 1) }

    it 'devuelve un usuario' do
      get "/api/v1/users/#{data_search.id}"
      expect(response).to have_http_status(:success)
      resp = JSON.parse(response.body)
      expect(resp['name']).to eq("Usuario search")
    end

    it 'crea un nuevo usuario' do
      expect {
        post '/api/v1/users', params: data_create
      }.to change(Users, :count).by(1)

      expect(response).to have_http_status(:created)

      resp = JSON.parse(response.body)
      expect(resp['name']).to eq('Usuario create')
    end

    it 'modifica un usuario' do
      new_name = { name: 'Usuario edit new' }
      put "/api/v1/users/#{data_edit.id}", params: new_name

      expect(response).to have_http_status(:ok)
      data_edit.reload
      expect(data_edit.name).to eq('Usuario edit new')
    end

    it 'borra un usuario' do
      delete "/api/v1/users/#{data_delete.id}"
      expect(response).to have_http_status(204)
      data_delete.reload
      expect(data_delete.active).to eq(0)
    end
   
  end

end