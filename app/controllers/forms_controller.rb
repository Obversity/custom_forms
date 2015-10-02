class FormsController < ApplicationController

  def index
    @forms = Form.all
  end

  def show
    @form = Form.find(params[:id])
    @errors = {}
    @sub = {}
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
    @sub = params[:submission]

    matches = {}

    #Date input matching stuff?
    @sub.keys.each do |key|

      match = key.match(/(^(\d)\((.*)\))/)
      unless match.nil?

        unless matches[match[2]].nil?
          @sub[key] = "#{matches[match[2]]} #{@sub[key]}"
        end

        matches[match[2]] = @sub[key]
        @sub[key] = nil
      end

      @sub.merge!(matches)

    end

    # make sure that errors is defined as an array, otherwise things will break
    @errors = {}

    # validate each field
    @form.fields.each do |field|
      field_data = @sub[field.id.to_s]
      field_errors = field.errors2(field_data)
      @errors[field.id] = field_errors if !field_errors.empty?
    end

    # if we have no errors, submit the form; otherwise reject the submission
    if @errors.length == 0
      @sub = Submission.create(data: @sub.to_json, form: @form)
      redirect_to "/forms/read/#{@sub.id}"
    else
      render :show
    end

  end

  def read
    @sub = Submission.find(params[:submission_id])
  end

  private

  def form_params
    params.require(:form).permit(:title, :description, fields_attributes: [:id, :field_type, :label, :hint, :placeholder, :required, :class_name, :wrapper_class])
  end

end
