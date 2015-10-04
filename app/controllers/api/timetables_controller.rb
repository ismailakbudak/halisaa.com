class Api::TimetablesController < Api::ApplicationController

  before_action :set_astroturf
  before_action :check_request

  def index
    timetables  = @astroturf.timetables.not_empty.after_number_month_ago(6)
    events      = Array.new()
    timetables.each do |timetable|
      event = {
        id: timetable.id,
        title: timetable.status_i18n,
        start: timetable.start,
        end: timetable.finish,
        destroyAble: false,
        editable: false,
        className: "timetable #{timetable.status}",
      }
      events.push event
    end
    render json: { success: true, events: events }, status: 200
  end

  private
    def set_astroturf
      @astroturf = Astroturf.find(params[:astroturf_id])
    end

    def check_request
      redirect_to request.referer if !request.xhr?
    end

end
