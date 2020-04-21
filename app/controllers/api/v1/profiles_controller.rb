# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    claimed_tasks = current_user.accepted_tasks.empty? ? "You don't have any claimed tasks." : current_user.accepted_tasks
    created_tasks = current_user.tasks.empty? ? "You don't have any ongoing tasks." : current_user.tasks
    render json: { claimed_tasks: claimed_tasks, created_tasks: created_tasks }
  end
end
