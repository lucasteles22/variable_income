class EarningsController < ApplicationController
  before_action :authenticate_user!

  def upload
    response = Earnings::Extract.call(upload_params.path, current_user)

    render status: 204 if response
    render status: 422
  end

  private

  def upload_params
    params.require(:file)
  end
end
