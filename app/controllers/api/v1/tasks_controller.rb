class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[create update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_error
  before_action :restrict_user_to_have_one_active_task, only: %i[create]

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
    task = Task.find(params[:id])
    if params[:activity]
      if params[:activity] == "confirmed" && task.task_items.count < 40 && task.task_items.count >= 5
        task.update_attribute(:status, 'confirmed')
        render json: { message: "Your task has been confirmed" }
      else
        render_error_message(task)
      end
    else
      product = Product.find(params[:product_id])
      task.task_items.create(product: product)
      render json: create_json_response(task)
    end
  end

  private

  def restrict_user_to_have_one_active_task
    if current_user.tasks.any?{|task| task.status == 'pending' || 'confirmed'}
      render json: { error: "You already have an active task pending" }, status: 403
      return
    end
  end

  def render_error_message(task)
    case
    when task.task_items.count >= 40
      message = "You have to many products selected."
    when task.task_items.count < 5
      message = "You have to pick atleast 5 products."
    else
      message = "Internal problem. Contact support. No activity specified"
    end

    render json: { error_message: message }, status: 400
  end

  def render_active_record_error(error)
    render json: { error_message: "Internal problem. Contact support. #{error.message}" }, status: 400
  end

  def create_json_response(task)
    json = { task: TaskSerializer.new(task) }
    json.merge!(message: "The product has been added to your request")
  end
end
