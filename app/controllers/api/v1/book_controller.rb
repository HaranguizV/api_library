module Api
    module V1
        class BookController < ActionController::API
            
            # GET /book/all
            def all
                @book = Book.select(:id,:name,:score,:total_reviews).where(active: 1).limit(50)
                if Book.where(active: 1) != 0
                    books = @book.map do |book|
                        {
                            id: book.id,
                            name: book.name,
                            score: book.total_reviews != nil && book.total_reviews.to_i >2 ? book.score : "Sin puntuación"
                        }
                    end
                    render json: {"books": books}
                else
                    render json: {"message": "No hay libros disponibles"}
                end
            end

            # GET /book
            def show
                params.require(:id)
                @book = Book.find_by(id: params[:id].to_i, active: 1)
                @reviews = Reviews.where(book_id: params[:id].to_i, active: 1)
                if @book
                    book = @book.attributes
                    book["score"] = @book.total_reviews != nil && @book.total_reviews.to_i >2 ? @book.score : "Sin puntuación"
                    render json: {"book": book, "reviews": @reviews}
                else
                    render json: {"message": "Este libro no existe"}, status: 409
                end
            end

            # POST /book
            def create
                params.expect(:name, :user_id)
                @book = Book.new
                @book.name = params[:name]
                @book.score = 0.0
                @book.user_id = params[:user_id]
                @book.total_reviews = 0
                @book.created_at = Time.now()
                @book.updated_at = Time.now()
                @book.active = 1
                if @book.save
                    render json: @book, status: :created
                else
                    render json: {"message":"Error al crear el registro"}, status: :unprocessable_entity
                end
            end

            # PUT /book/:id
            def update
                params.expect(:id)
                @book = Book.find_by(id: params[:id].to_i, active: 1)
                if @book && @book.update(name: params[:name], updated_at: Time.now())
                    render json: @book
                else
                    render json: {"message": "No se puede actualizar el registro"}, status: 409
                end
            end

            # DELETE /book/:id
            def delete
                params.expect(:id)
                @book = Book.find_by(id: params[:id].to_i, active: 1)
                if @book != 0
                    @book.update(active: 0, updated_at: Time.now())
                    render json: {"message": "Eliminación exitosa"}, status: 204
                else
                    render json: {"message": "Este libro no existe"}, status: 409
                end
            end

        end
    end
end