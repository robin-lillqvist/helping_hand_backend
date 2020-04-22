# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = current_user.accepted_tasks.empty? ? "You don't have any claimed tasks." : current_user.accepted_tasks
    created_tasks = current_user.tasks.empty? ? "You don't have any ongoing tasks." : current_user.tasks
    render json: { claimed_tasks: claimed_tasks, created_tasks: created_tasks }
  end

  def update
    task = Task.find(params[:id])
    if task.is_declinable?(current_user)
      task.update(status: params[:activity], provider: current_user)
      render json: { message: 'Your claimed task has been declined' }
    else
      render json: { error_message: 'You are not authorized for this action.' }, status: 401
    end
  end
end
