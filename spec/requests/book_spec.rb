require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'SUITE /api/v1/book' do

    let(:data_create) { attributes_for(:book, name: 'Libro create', user_id: 1) }
    let!(:book_edit) { create(:book, name: 'Libro edit old') }

    it 'devuelve una lista con todos los libros' do
      create(:book, name: "Libro1", score: "5.0")
      get '/api/v1/book/all'
      expect(response).to have_http_status(:success)
    end
    
    it 'devuelve un solo libro de la lista, y con menos de 2 reviews' do
      create(:book, id: 1, name: "Libro1", score: "5.0")
      get '/api/v1/book/1'
      expect(response).to have_http_status(:success)
      resp = JSON.parse(response.body)
      expect(resp['book']['name']).to eq("Libro1")
      expect(resp['book']['score']).to eq("Sin puntuación")
    end

    it 'devuelve un solo libro de la lista, y con mas de 2 reviews' do
      create(:book, id: 1, name: "Libro12", score: 5.0, total_reviews: 3)
      get '/api/v1/book/1'
      expect(response).to have_http_status(:success)
      resp = JSON.parse(response.body)
      expect(resp['book']['name']).to eq("Libro12")
      expect(resp['book']['score']).to eq(5.0)
    end

    it 'devuelve error si el usuario no existe' do
      create(:book, id: 1, name: "Libro1", score: "5.0")
      get '/api/v1/book/2'
      expect(response).to have_http_status(409)
      resp = JSON.parse(response.body)
      expect(resp['message']).to eq("Este libro no existe")
    end

    it 'crea un nuevo libro' do
      expect {
        post '/api/v1/book', params: data_create
      }.to change(Book, :count).by(1)

      expect(response).to have_http_status(:created)

      resp = JSON.parse(response.body)
      expect(resp['name']).to eq('Libro create')
    end

    it 'modifica un libro' do
      new_name = { name: 'Libro edit new' }
      put "/api/v1/book/#{book_edit.id}", params: new_name

      expect(response).to have_http_status(:ok)
      book_edit.reload
      expect(book_edit.name).to eq('Libro edit new')
    end

    it 'borra un libro' do
      delete "/api/v1/book/#{book_edit.id}"
      expect(response).to have_http_status(204)
      book_edit.reload
      expect(book_edit.active).to eq(0)
    end

  end

end