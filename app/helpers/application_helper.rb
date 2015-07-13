module ApplicationHelper
  def success( data, message: "Success!", error: false  )
    { :status => 200, :message => message, :error => error, :data => data }
  end
  def money( amount  )
     t('money.try', amount: amount)
  end
end
