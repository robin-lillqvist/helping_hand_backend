
require 'rails_helper'

RSpec.describe 'PUT api/v1/tasks/:id', type: :request do
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }
  let(:task) { create(:task, user: user) }
  let!(:task_items) { 5.times { create(:task_item, task: task) } }

  let(:user_2) { create(:user, user: user_2) }


  describe 'Succesfully claims task' do
    before do
      put "/api/v1/tasks/#{task.id}",
          params: { activity: 'confirmed' },
          headers: user_headers
    end

    before do
      put "/api/v1/tasks/#{task.id}",
          params: { activity: 'claimed' },
          headers: user_headers
    end

    it "returns a successful message status 200" do
      binding.pry
      expect(response).to have_http_status 200
    end
  end
end