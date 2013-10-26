namespace :email do
  desc "Check emails on gmail"
  task :check => :environment do
    User.all.each do |user|
      begin
        gmail = GmailPoll.new user.id
        gmail.start
      rescue Exception => e
        puts e
      end
    end
  end
end
