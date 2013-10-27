class GmailPoll
  def initialize user_id
    @user        = User.find(user_id)
    @white_list  = @user.contacts.pluck(:email)
    @actions     = ["read"]
  end

  def start
    @imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true,
                       certs = nil, verify = false)

    @imap.authenticate('XOAUTH2', @user.email, @user.token)
    @imap.select('INBOX')

    @imap.search(["SINCE", Date.today.strftime('%d-%b-%Y')]).each do |email_id|
      message = @imap.fetch(email_id, 'RFC822')[0].attr['RFC822']
      mail    = Mail.read_from_string message

      process_email mail, email_id
    end

    @imap.expunge
  end

  def process_email mail, mail_id
    if action?(mail.from, mail.subject)
      account = @user.accounts.where(:action => mail.subject).first

      acount.action! mail.text_part.body.decoded

      archive! mail_id
    end
  end

  def action? from, subject
    @white_list.include?(from[0]) && @actions.include?(subject)
  end

  def archive! mail_id
    @imap.copy(mail_id, "[Gmail]/All Mail")
    @imap.store(mail_id, "+FLAGS", [:Deleted])
  end
end
