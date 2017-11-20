class CampaignMailer < ApplicationMailer
  
    def raffle(campaign, member, friend)
      @campaign = campaign
      @member = member
      @friend = friend
      mail to: @member.email, subject: "Nosso Amigo Secreto: #{@campaign.title}"
    end

    def error_mailer(campaign)
      @campaign = campaign
      mail to: @campaign.user.email, subject: "Erro ao criar campanha: #{@campaign.title}"
    end
  end