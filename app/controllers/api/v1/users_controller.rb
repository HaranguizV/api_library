module Api
    module V1
        class UsersController < ActionController::API
            
            # GET /users/:id
            def show
                params.expect(:id)
                @user = Users.find_by(id: params[:id].to_i, active: 1)
                if @user
                    render json: @user
                else
                    render json: {"message": "Este usuario no existe"}, status: 409
                end
            end


            # POST /users
            def create
                params.expect(:name)
                @user = Users.new
                @user.name = params[:name]
                @user.created_at = Time.now()
                @user.updated_at = Time.now()
                @user.active = 1
                if @user.save
                    render json: @user, status: :created
                else
                    render json: {"message":"Error al crear el registro"}, status: :unprocessable_entity
                end
            end

            # PUT /users/:id
            def update
                params.expect(:id)
                @user = Users.where(id: params[:id].to_i, active: 1).limit(1)
                if @user.count() != 0 && @user.update(name: params[:name], updated_at: Time.now())
                    render json: @user
                else
                    render json: {"message": "No se puede actualizar el registro"}, status: 409
                end
            end

            # DELETE /users/:id
            def delete
                params.expect(:id)
                @user = Users.where(id: params[:id].to_i, active: 1).limit(1)
                if @user.count() != 0
                    @user.update(active: 0, updated_at: Time.now())
                    Book.where(user_id: params[:id]).update_all(active: 0)
                    Reviews.where(user_id: params[:id]).update_all(active: 0)
                    render json: {"message": "Eliminación exitosa"}, status: 204
                else
                    render json: {"message": "Este usuario no existe"}, status: 409
                end
            end

            # REACTIVATE /users/:id
            def reactivate
                params.expect(:id)
                @user = Users.where(id: params[:id].to_i).limit(1)
                if @user.count() != 0
                    @user.update(active: 0, updated_at: Time.now())
                    render json: {"message": "Usuario Reactivado"}, status: 203
                else
                    render json: {"message": "Este usuario no existe"}, status: 409
                end
            end

        end
    end
end