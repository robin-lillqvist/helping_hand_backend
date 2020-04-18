class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error
  before_action :restrict_user_to_have_one_active_task, only: %i[create]
  before_action :find_task, only: :update

  def index
    tasks = Task.where(status: :confirmed)
    render json: tasks
  end

  def create
    task = Task.create(user_id: params[:user_id])
    task.task_items.create(product_id: params[:product_id])
    render json: create_json_response(task)
  end

  def update
    case params[:activity]
    when "confirmed"
      if @task.is_confirmable?
        @task.update(:status, params[:activity])
        render json: { message: "Your task has been confirmed" }
      else
        render_error_message(@task)
      end
    when "claimed"
      if @task.is_claimable?(current_user)
        @task.update(status: params[:activity], provider: current_user)
        render json: { message: "You claimed the task" }
      else
        render_error_message(@task)
      end
    else
      product = Product.find(params[:product_id])
      @task.task_items.create(product: product)
      render json: create_json_response(@task)
    end
  end
 
  private

  def find_task
    @task = Task.find(params[:id])
  end

  def restrict_user_to_have_one_active_task
    if current_user.tasks.any? { |task| task.status == "confirmed" }
      render json: { error: "You can only have one active task at a time." }, status: 403
      return
    end
  end

  def render_error_message(task)
    case
    when task.task_items.count >= 40
      message = "You have selected too many products."
      request_status = 403
    when task.task_items.count < 5
      message = "You have to pick at least 5 products."
      request_status = 403
    when task.user_id == current_user.id
      message = "You cannot claim your own task"
      request_status = 405
    else
      message = "We are experiencing internal errors. Please refresh the page and contact support. No activity specified"
      request_status = 500
    end

    render json: { error_message: message }, status: request_status
  end

  def render_active_record_error(error)
    render json: { error_message: "We are experiencing internal errors. Please refresh the page and contact support. #{error.message}" }, status: 400
  end

  def create_json_response(task)
    json = { task: TaskSerializer.new(task) }
    json.merge!(message: "The product has been added to your request")
  end
end
