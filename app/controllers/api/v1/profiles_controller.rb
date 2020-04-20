class Api::V1::ProfilesController < ApplicationController
    before_action :authenticate_user!

    def index
    claimed_tasks = Task.where(status: :claimed )
    render json: claimed_tasks
    end

    private

    # def current_user

    # end
end
