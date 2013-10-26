#! ruby
#
# Usage
# bundle exec ruby bootstrap.rb NewApp
# Where NewApp is the name for your new rails application
#
# Script:
# - updates the app name throughout the application
# - removes origin reference
# - sets a new secret
# - sets a new session store key

class NewApp

  FILES = [
            'config/application.rb',
            'config/environment.rb',
            'config/environments/development.rb',
            'config/environments/production.rb',
            'config/environments/test.rb',
            'config/initializers/secret_token.rb',
            'config/initializers/session_store.rb',
            'config/routes.rb',
            'config.ru',
            'Rakefile',
            'README.md'
          ]

  ORIGINAL_NAME = /BaseApplication/

  def initialize name
    @name = name
  end

  def set_new_application_name
    FILES.each do |file_name|
      text    = File.read(file_name)
      replace = text.gsub!(ORIGINAL_NAME, @name)
      File.open(file_name, "w") do |file|
        file.puts replace

        puts "#{file_name} updated"
      end
    end
  end

  def remove_master
    system "git remote rm origin"
    puts "Origin removed"
  end

  def set_secret
    pattern  = /'(.)*'/
    secret   = SecureRandom.hex(64)
    filepath = "config/initializers/secret_token.rb"

    text     = File.read(filepath)
    replace  = text.gsub!(pattern,"'#{secret}'")

    File.open(filepath, 'w') {|f| f.write(text) }

    puts "Updated secret"
  end

  def set_session_store
    pattern       = /'(.)*'/
    session_name  = "_#{@name.downcase}_session"
    filepath      = "config/initializers/session_store.rb"

    text     = File.read(filepath)
    replace  = text.gsub!(pattern,"'#{session_name}'")

    File.open(filepath, 'w') {|f| f.write(text) }

    puts "Updated session store"
  end
end

app = NewApp.new ARGV[0]
app.set_new_application_name
app.remove_master
app.set_secret
app.set_session_store
