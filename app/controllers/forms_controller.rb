class FormsController < ApplicationController

  def index
    @forms = Form.all
  end

  def show
    @form = Form.find(params[:id])
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.create(form_params)
    redirect_to @form
  end

  def submit

    # get the form's fields
    @form = Form.find(params[:submission][:form_id])


    # get the data that was submitted
    @submission = params[:submission]

    matches = {}

    #Date input matching stuff?
    @submission.keys.each do |key|

      match = key.match(/(^(\d)\((.*)\))/)
      unless match.nil?

        unless matches[match[2]].nil?
          @ubmission[key] = "#{matches[match[2]]} #{submission[key]}"
        end

        matches[match[2]] = @submission[key]
        @submission[key] = nil
      end

      @submission.merge!(matches)

    end

    # make sure that errors is defined as an array, otherwise things will break
    @errors = {}

    # validate each field
    @form.fields.each do |field|
      field_data = @submission[field.id.to_s]
      field_errors = field.errors2(field_data)
      @errors[field.id] = field_errors if !field_errors.empty?
    end

    binding.pry

    # if we have no errors, submit the form; otherwise reject the submission
    if @errors.length == 0
      @submission = Submission.create(data: @submission.to_json, form: @form)
      redirect_to "/forms/read/#{@submission.id}"
    else
      render :show
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
