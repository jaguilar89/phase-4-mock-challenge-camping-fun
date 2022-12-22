class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :camper_not_created_response

  def index
    campers = Camper.all
    render json: campers
  end

  def show
    camper = Camper.find(params[:id])
    render json: camper, serializer: CamperActivitiesSerializer, status: :ok
  end

  def create
    new_camper = Camper.create!(camper_params)
    render json: new_camper, status: :created
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

  def camper_not_found_response
    render json: { error: "Camper not found" }, status: :not_found
  end

  def camper_not_created_response
    render json: { errors: ["validation errors"] }, status: :unprocessable_entity
  end
end
