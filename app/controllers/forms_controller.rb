class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
  end

#   private
#     def forms_params
#
#     end

  def submit
    data = params[:submission]
    form = Form.find(params[:submission][:form_id])
    errors = []
    form.fields.each do |field|
      field.field_validations.each do |validation|
        validation_type = FieldValidation::VALIDATION_TYPES[validation.validation_id]
        is_good = FieldValidation.send(validation_type, data[field.id.to_s])


        errors << "#{field.label} does not validate with #{validation_type} correctly." unless is_good

      end
    end

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

end
