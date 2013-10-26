class GmailPoll

  def initialize user_id
    @white_list = User.find(user_id).contacts
    @actons = ["read"]
  end

  def start
    gmail = Gmail.connect("ENTER EMAIL", "ENTER PASS")

    gmail.inbox.find(:after => Date.yesterday).each do |email|
      if action?(email.message.from, email.message.subject)
        action! email.message.text_part.body.decoded
      end
    end
  end

  def action? from, subject
    @white_list.include?(from[0]) && @actions.include?(subject)
  end

  def action! data
    puts "Adding to pocket #{data}"
  end
end
