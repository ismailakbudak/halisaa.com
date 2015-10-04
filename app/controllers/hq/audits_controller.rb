class Hq::AuditsController < Hq::ApplicationController
  add_breadcrumb I18n.t('activerecord.models.audits'), :hq_audits_path
  def index
    @search = Audit.where.not(:user_id => nil).includes(:user).reorder('created_at DESC').search(params[:q])
    @audits = @search.result(distinct: true).paginate(page: params[:page])
    @auditable_types = Audit.select('auditable_type').group('auditable_type').reorder('')
  end

  def show
    @audit = Audit.find(params[:id])
    add_breadcrumb @audit.id, hq_audit_path(id: @audit)
  end
end
