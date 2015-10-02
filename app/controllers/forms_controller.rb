class FormsController < ApplicationController

  def show
    @form = Form.find(params[:id])
  end

  def new
    @form = Form.new
  end

  def create

    @form = Form.create(form_params)
    binding.pry
    # @fields = params[:fields]
    # @fields.each do |field|
    #   #TODO: do some fancy field adding magic here
    # end
    # binding.pry
  end

#   private
#     def forms_params
#
#     end

  def submit

    # get the form's fields
    form = Form.find(params[:submission][:form_id])

    # get the data that was submitted
    data = params[:submission]

    matches = {}

    data.keys.each do |key|

      match = key.match(/(^(\d)\((.*)\))/)
      unless match.nil?

        unless matches[match[2]].nil?
          data[key] = "#{matches[match[2]]} #{data[key]}"
        end

        matches[match[2]] = data[key]
        data[key] = nil
      end

      data.merge!(matches)

    end

    # make sure that errors is defined as an array, otherwise things will break
    errors = []

    # validate each field
    form.fields.each do |field|
      field.field_validations.each do |validation|

        # check what kind of validation we're doing.
        validation_type = FieldValidation::VALIDATION_TYPES[validation.validation_id]

        # check whether the value validates
        valid = FieldValidation.send(validation_type, data[field.id.to_s])

        # push error messages into the errors array
        errors << "#{field.label} does not validate with #{validation_type} correctly." unless valid

      end
    end

    # if we have no errors, submit the form; otherwise reject the submission
    if errors.length == 0
      @submission = Submission.create(data: data.to_json, form: form)
      redirect_to "/forms/read/#{@submission.id}"
    else
      session[:errors] = errors
      session[:submission] = data

      redirect_to "/forms/#{form.id}"
    end

  end

  def read
    @submission = Submission.find(params[:submission_id])
  end

  private

  def form_params
    params.require(:form).permit(:title, :description, fields_attributes: [:id, :field_type, :label, :hint, :placeholder, :required, :class_name, :wrapper_class])
  end

end
