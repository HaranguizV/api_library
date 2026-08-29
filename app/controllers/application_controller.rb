class ApplicationController < ActionController::API
    rescue_from ActionController::ParameterMissing, with: :handle_missing_parameters


    render json: { 
      status: 400,
      error: "Faltan parámetros obligatorios. Intente nuevamente", 
      detalle: exception.message 
    }, status: :bad_request
  end

end
