class ApplicationController < ActionController::Base
  def not_found
    render json: {message: 'route not found'}, status: 404
  end
end
