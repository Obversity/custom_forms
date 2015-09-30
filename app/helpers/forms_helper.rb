module FormsHelper

  # method for displaying the errors after the form has been submitted and rejected
  def get_errors
    # unless there are no errors
    unless session[:errors].nil?
      # pass the errors to the errors variable
      errors = session[:errors]

      # clear the errors, so that they are only shown once.
      session[:errors] = nil

      # pass the errors to the @errors variable
      errors

    end
  end

  # method for displaying the form data after a form has been submitted and rejected
  def get_form_data
    # make sure that data is always a hash
    data = {}

    # unless there has been no submissions
    unless session[:submission].nil?
      # store the data in a temporary variable
      data = session[:submission]

      # clear the session's submission, so that it is only shown once
      session[:submission] = nil
    end

    #pass the data to the data variable
    @data = data
  end

end
