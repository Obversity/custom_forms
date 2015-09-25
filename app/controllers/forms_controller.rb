class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
  end

#   private
#     def forms_params
#
#     end

  def submit
    binding.pry
    @submission = Submission.create(data: params[:submission].to_json, form: Form.find(params[:submission][:form_id]))
    redirect_to "/forms/read/#{@submission.id}"
  end

  def read
    @submission = Submission.find(params[:submission_id])
  end

end
