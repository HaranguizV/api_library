require 'rails_helper'

RSpec.describe 'Reviews API', type: :request do
  describe 'SUITE /api/v1/reviews' do

    let!(:data_book_create) { create(:book, name: 'Book Test', active: 1, score: 2.0) }
    let(:data_create) { attributes_for(:reviews, review: 'Review create', book_id: data_book_create.id, user_id: 1, score: 5.0) }
    let!(:data_edit) { create(:reviews, review: 'Review edit old', book_id: data_book_create.id, user_id: 1, score: 4.5) }
    let!(:data_search) { create(:reviews, review: 'Review search', book_id: data_book_create.id, user_id: 1, score: 4.0) }
    let!(:data_delete) { create(:reviews, review: 'Review delete', book_id: data_book_create.id, user_id: 1, score: 3.5) }

    it 'devuelve un usuario' do
      get "/api/v1/reviews/#{data_search.id}"
      expect(response).to have_http_status(:success)
      resp = JSON.parse(response.body)
      expect(resp['review']).to eq("Review search")
    end

    it 'crea una nueva review' do
      expect {
        post '/api/v1/reviews', params: data_create
      }.to change(Reviews, :count).by(1)

      expect(response).to have_http_status(:created)

      resp = JSON.parse(response.body)
      expect(resp['review']).to eq('Review create')
    end

    it 'modifica una review' do
      edit_review = { review: 'Review edit new', book_id: data_book_create.id, user_id: 1, score: 4.5 }
      put "/api/v1/reviews/#{data_edit.id}", params: edit_review
      expect(response).to have_http_status(:ok)
      data_edit.reload
      expect(data_edit.review).to eq('Review edit new')
    end

    it 'borra una review' do
      delete "/api/v1/reviews/#{data_delete.id}"
      expect(response).to have_http_status(204)
      data_delete.reload
      expect(data_delete.active).to eq(0)
    end

    it 'Limpia los puntajes de libros' do
      patch "/api/v1/reviews/clean"
      expect(response).to have_http_status(200)
      data_book_create.reload
      expect(data_book_create.score).to eq(4.0)
    end
   
  end

end