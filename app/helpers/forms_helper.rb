module FormsHelper
  def get_errors
    if !session[:errors].nil?
      errors = session[:errors]
      session[:errors] = nil
    end
    @errors = errors
  end

  def get_form_data
    data = {}
    if !session[:submission].nil?
      data = session[:submission]
      session[:submission] = nil
    end
    @data = data
  end
end
