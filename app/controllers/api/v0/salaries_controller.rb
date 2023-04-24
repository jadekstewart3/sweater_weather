class Api::V0::SalariesController < ApplicationController
  def show
    if params[:destination].empty?
      render json: { errors: "No matches found" }, status: :bad_request
    else
      salaries = SalariesFacade.new.get_city_salaries(params[:destination])
      render json: SalariesSerializer.new(salaries)
    end
  end

  private
  def salaries_params
    params.permit(:destination)
  end
end

