require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "POST #create" do
    before(:each) do
      @campaign = create(:campaign, user: @current_user)
      @member_attributes = attributes_for(:member).merge(campaign_id: @campaign.id)
      post :create, params: {member: @member_attributes}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "create member on database" do
      expect(Member.last.name).to eql(@member_attributes[:name])
      expect(Member.last.email).to eql(@member_attributes[:email])
    end
  end

  describe "DELETE #destroy" do
    context "Is owner of campaign" do
      before(:each) do
        @campaign = create(:campaign, user: @current_user)
        @member = create(:member, campaign: @campaign)
        delete :destroy, params: {id: @member.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "Isn't owner of campaign" do
      before(:each) do
        campaign = create(:campaign, user: @current_user)
        member = create(:member)
        delete :destroy, params: {id: member.id}
      end

      it "returns http forbidden" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @new_member_attributes = attributes_for(:member)
    end

    context "User is the Campaign Owner" do
      before(:each) do
        campaign = create(:campaign, user: @current_user)
        member = create(:member, campaign: campaign)
        put :update, params: {id: member.id, member: @new_member_attributes}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Campaign have the new attributes" do
        expect(Member.last.name).to eq(@new_member_attributes[:name])
        expect(Member.last.email).to eq(@new_member_attributes[:email])
      end
    end

    context "User isn't the Campaign Owner" do
      it "returns http forbidden" do
        member = create(:member)
        put :update, params: {id: member.id, campaign: @new_member_attributes}
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end