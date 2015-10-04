class Api::Company::TimetablesController < Api::Company::ApplicationController

  before_action :set_astroturf
  before_action :check_request

  def index
    timetables  = @astroturf.timetables.not_empty.after_number_month_ago(1)
    events      = Array.new()
    timetables.each do |timetable|
      editable    = true
      destroyAble = true
      if timetable.finish.strftime('%Y-%m-%d %H:%M:%S') < Time.now.strftime('%Y-%m-%d %H:%M:%S') or Timetable.statuses[timetable.status] == Timetable.statuses[:booked]
        editable    = false
        destroyAble = false
      end
      event = {
        id: timetable.id,
        title: timetable.status_i18n,
        start: timetable.start,
        end: timetable.finish,
        destroyAble: destroyAble,
        editable: editable,
        className: "timetable #{timetable.status}",
        url: ''
      }
      events.push event
    end
    render json: { success: true, events: events }, status: 200
  end

  def update
    timetable = @astroturf.timetables.not_booked.find(params[:id])
    update    = timetable_params.merge(status: Timetable.statuses[:not_available])
    timetable.update! update
    render json: { success: true, timetable: timetable }, status: 200
  end

  def create
    empty_timetable = @astroturf.timetables.create!
    render json: { success: true, timetable: empty_timetable }, status: 200
  end

  def destroy
    timetable = @astroturf.timetables.not_booked.find(params[:id])
    timetable.destroy!
    render json: { success: true, timetable: timetable }, status: 200
  end

  private
    def set_astroturf
      @astroturf = current_company.astroturves.find(params[:astroturf_id])
    end

    def check_request
      redirect_to request.referer if !request.xhr?
    end

    def timetable_params
      params.permit(:start, :finish)
    end
end
