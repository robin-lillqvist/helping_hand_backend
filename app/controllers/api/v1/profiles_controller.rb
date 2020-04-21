# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    ongoing_tasks = Task.where(status: %w[claimed delivered])
    .where(provider_id: current_user.id)
    .or(Task.where(user_id: current_user.id))

    if ongoing_tasks.empty?
      render json: {message: "You don't have any ongoing task."}
    else
      render json: ongoing_tasks
    end
  end
end
