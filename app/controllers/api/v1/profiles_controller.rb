# frozen_string_literal: true

class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: :show

  def show
    render json: @user_profile
  end

  def index
    claimed_tasks = current_user.accepted_tasks.empty? ? "You don't have any claimed tasks." : current_user.accepted_tasks
    created_tasks = current_user.tasks.empty? ? "You don't have any ongoing tasks." : current_user.tasks
    render json: { claimed_tasks: claimed_tasks, created_tasks: created_tasks }
  end

  private

  def find_user
    @user_profile = User.find(params[:id])
  end
end
