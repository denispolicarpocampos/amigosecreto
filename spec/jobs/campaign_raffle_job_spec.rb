require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  include ActiveJob::TestHelper
  
  before(:each) do
    @current_user = FactoryGirl.create(:user)
    @campaign = create(:campaign, user: @current_user)
    @job = CampaignRaffleJob.perform_later(@campaign)
  end

  describe "#perform_later" do
    it "job was enqueued" do
      expect {CampaignRaffleJob.perform_later(@campaign)}.to have_enqueued_job
    end

    it "matches with enqueued job" do
      expect {CampaignRaffleJob.perform_later(@campaign)}.to have_enqueued_job.on_queue("emails")
    end
  end

end
