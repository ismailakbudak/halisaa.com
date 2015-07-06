class Api::CitiesController < Api::ApplicationController

  def index
    render json: success( City.all )
  end

  def show
    render json: success( Town.where(city_id: params[:id]) )
  end

end
