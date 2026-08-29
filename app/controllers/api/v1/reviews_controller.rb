module Api
    module V1
        class ReviewsController < ActionController::API
            

            #GET /reviews/:id
            def show
                params.expect(:id)
                @review = Reviews.find_by(id: params[:id].to_i, active: 1)
                if @review
                    render json: @review
                else
                    render json: {"message": "Esta review no existe"}, status: 409
                end
            end


            # POST /reviews
            def create
                params.expect(:review, :score, :book_id, :user_id)
                if params[:review].size > 1000
                    render json: {"message":"La review no cumple con el tamaño necesario (menos de 1000 caracteres)"}, status: 409 and return
                end
                @book = Book.where(id: params[:book_id].to_i, active: 1).limit(1)
                if @book.count() > 0
                    @review = Reviews.new
                    @review.review = params[:review]
                    @review.score = params[:score]
                    @review.book_id = params[:book_id]
                    @review.user_id = params[:user_id]
                    @review.created_at = Time.now()
                    @review.updated_at = Time.now()
                    @review.active = 1
                    if @review.save
                        calc_review_score(params[:book_id].to_i)
                        render json: @review, status: :created
                    else
                        render json: {"message":"Error al crear el registro"}, status: :unprocessable_entity
                    end
                else
                    render json: {"message":"El libro al que se hace review no existe"}, status: 409
                end
            end

            # PUT /reviews/:id
            def update
                params.expect(:id, :book_id, :score, :review)
                @book = Book.where(id: params[:book_id], active: 1).limit(1)
                if @book.count() != 0
                    @review = Reviews.where(id: params[:id].to_i, active: 1).limit(1)
                    if @review.count() != 0 && @review.update(review: params[:review], score: params[:score], updated_at: Time.now())
                        calc_review_score(params[:book_id].to_i)
                        render json: @review
                    else
                        render json: {"message": "No se puede actualizar el registro"}, status: 409
                    end
                else
                    render json: {"message":"El libro al que se hace review no existe"}, status: 409
                end
            end

            # DELETE /reviews/:id
            def delete
                params.expect(:id)
                @review = Reviews.find_by(id: params[:id].to_i, active: 1)
                if @review
                    @review.update(active: 0, updated_at: Time.now())
                    calc_review_score(@review.book_id.to_i)
                    render json: {"message": "Eliminación exitosa"}, status: 204
                else
                    render json: {"message": "Esta review no existe"}, status: 409
                end
            end

            # PATCH /reviews/clean
            def clean
                @books = Book.where(active: 1)
                @books.find_each do |book|
                    calc_review_score(book.id.to_i)
                end
               render json: {"message": "Puntajes modificados exitosamente"}, status: 200
            end

            # Recalcular el score de un libro
            def calc_review_score(book_id)
                @book = Book.where(id: book_id, active: 1).limit(1)
                if @book.count() != 0
                    @reviews = Reviews.where(book_id: book_id, active: 1)
                    if @reviews.count() > 0
                        @book.update(score: @reviews.average(:score).round(1), total_reviews: @reviews.count())
                    end
                else
                    render json: {"message":"El libro al que se calcular el puntaje no existe"}, status: 409
                end
            end

        end
    end
end