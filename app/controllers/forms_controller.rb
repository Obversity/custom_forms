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
  end
end
