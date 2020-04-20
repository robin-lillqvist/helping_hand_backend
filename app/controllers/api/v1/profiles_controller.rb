# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = Task.where(status: %w[claimed delivered])
    claimed_tasks.each do |task|
      
      if task.provider_id == current_user.id || task.user_id == current_user.id
        return render json: claimed_tasks
      else

        return render json: { error_message: 'You are not authorized, please contact support.' }, status: 401
      end
    end
  end
end
