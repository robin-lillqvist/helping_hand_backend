class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = Task.where(status: :claimed)
    claimed_tasks.each do |task|
      if task.provider_id == current_user.id
        render json: claimed_tasks
        return
      else
        render json: { error_message: "Error" }, status: 401
        return
      end
    end
  end
end
