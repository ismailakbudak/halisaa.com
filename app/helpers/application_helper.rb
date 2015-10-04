module ApplicationHelper
  def success( data, message: 'Success!', error: false  )
    { :status => 200, :message => message, :error => error, :data => data }
  end
  def money( amount  )
     t('money.try', amount: amount)
  end
  def set_active(array, class_name: 'active')
    array.to_s.include?(request.path) ? class_name : ''
  end
end
