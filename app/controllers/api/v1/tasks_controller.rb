class Api::V1::TasksController < ApplicationController

  def index
    @tasks = Task.where(confirmed: true)
    render json: @tasks
  end

  def create
    task = Task.create
    task.task_items.create(product_id: params[:product_id])
    render json: create_json_response(task)
  end

  def update
    task = Task.find(params[:id])
    if params[:activity]
      task.update_attribute(:confirmed, true)
      render json: { message: "Your task has been confirmed" }
    else
      product = Product.find(params[:product_id])
      task.task_items.create(product: product)
      render json: create_json_response(task)
    end
  end

  private

  def create_json_response(task)
    json = { task: TaskSerializer.new(task) }
    json.merge!(message: "The product has been added to your request")
  end
end
