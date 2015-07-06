module ApplicationHelper
  def success( data, message: "Success!"  )
    { :status => 200, :message => message, :data => data }
  end
end
