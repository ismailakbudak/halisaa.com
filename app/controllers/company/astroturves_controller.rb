class Company::AstroturvesController < Company::ApplicationController
  layout 'company/application'
  before_action :set_astroturf, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.astroturves'), :company_astroturves_path

  def index
    @search = current_company.astroturves.ransack(params[:q])
    @astroturves = @search.result.includes(:city).includes(:town).paginate(page: params[:page])
  end

  def new
    add_breadcrumb t('tooltips.new'), new_company_astroturf_path
    @astroturf = current_company.astroturves.new
    respond_with(@astroturf)
  end

  def create
    @astroturf = current_company.astroturves.new(astroturf_params)
    @astroturf.save
    respond_with(@astroturf, location: @astroturf.id.nil? ? company_astroturves_path : company_astroturf_path(@astroturf))
  end

  def edit
    add_breadcrumb @astroturf.name, company_astroturf_path(@astroturf)
    add_breadcrumb t('tooltips.edit'), edit_company_astroturf_path
  end

  def update
    @astroturf.update(astroturf_params)
    respond_with(@astroturf, location: company_astroturf_path(@astroturf))
  end

  def show
    add_breadcrumb @astroturf.name, company_astroturf_path(@astroturf)
    respond_with(@astroturf)
  end

  def destroy
    @astroturf.destroy
    respond_with(@astroturf, location: company_astroturves_path)
  end
  private

  def set_astroturf
    @astroturf = current_company.astroturves.find(params[:id])
  end

  def astroturf_params
    params.require(:astroturf).permit(:name, :address, :phone, :city_id, :town_id, :week_price, :weekend_price, :latitude, :longitude )
  end
end
