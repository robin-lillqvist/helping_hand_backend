class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = Task.where(status: :claimed)
    claimed_tasks.each do |task|
      if task.provider_id == current_user.id
        render json: claimed_tasks
      else
        render json: { error_message: "Fuck off!" }
      end
    end
  end

  # private
  # def task_provider
  #   claimed_tasks.provider.all? { |task| task.provider == current_user }
  # end
end
