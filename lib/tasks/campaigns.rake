task :campaigns => :environment do
  Campaign.expired_campaigns
end
