class GmailPoll
  WHITE_LIST = ["fraser@fraserdeans.com"]
  ACTIONS = ["read"]

  def self.start
    gmail = Gmail.connect("ENTER EMAIL", "ENTER PASS")

    gmail.inbox.find(:after => Date.yesterday).each do |email|
      if action?(email.message.from, email.message.subject)
        action! email.message.text_part.body.decoded
      end
    end
  end

  def self.action? from, subject
    WHITE_LIST.include?(from[0]) && ACTIONS.include?(subject)
  end

  def self.action! data
    puts "Adding to pocket #{data}"
  end
end
