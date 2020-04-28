class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error

  protected

  def render_active_record_error(error)
    render json: { error_message: "We are experiencing internal errors. Please refresh the page and contact support. #{error.message}" }, status: 500
  end

  def render_error_message(task)
    if task.task_items.count >= 40
      message = "You have selected too many products."
      request_status = 403
    elsif task.task_items.count < 5
      message = "You have to pick at least 5 products."
      request_status = 403
    elsif task.user_id == current_user.id && params[:activity] == "claimed"
      message = "You cannot claim your own task."
      request_status = 405
    elsif params[:activity] == "claimed"
      message = "The task has already been claimed!"
      request_status = 409
    elsif params[:activity] == "delivered" && task.status == 'claimed'
      message = "You haven't claimed this task, please contact support."
      request_status = 401
    elsif task.status != 'delivered' && params[:activity] == "finalized"
      message = "Please, wait until the request has been delivered."
      request_status = 403
    else
      message = "We are experiencing internal errors. Please refresh the page and contact support. No activity specified."
      request_status = 500
    end
    render json: { error_message: message }, status: request_status
  end
end

