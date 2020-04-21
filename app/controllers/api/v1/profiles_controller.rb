# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = Task.where(status: %w[claimed delivered]).where(provider_id: current_user.id).or(Task.where(user_id: current_user.id))
    render json: claimed_tasks
  end
end
