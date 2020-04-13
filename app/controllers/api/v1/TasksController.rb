class Api::V1::TasksController < ApplicationController
  def create
    task = Task.create
    binding.pry
    task.task_items.create(product_id: params[:product_id])
    render json: {message: "The product has been added to your request", task_id: task.id}
  end
end
