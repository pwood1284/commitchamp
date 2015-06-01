$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'
require 'commitchamp/user'
require 'commitchamp/contribution'
require 'commitchamp/repo'

module Commitchamp
  class App
    def initialize
      @github = Github.new
      @username = nil
    end

    def prompt(question, validator)
      puts question
      input = gets.chomp
      while input =~ validator
        puts "Please try again"
        puts question
        input = gets.chomp
      end
      puts input
    end

    def create_new_user
      puts "Create a new user: "
        name = gets.chomp
        @username = Commitchamp::User.create(:login => name)
      puts  "Thanks #{@username.name}!"
    end

    def run
      user_list
      fetch_repo
      # user_info = @github.get_user(@username)
      # User.create(user_info)
    end

    def fetch_repo
      puts "Would you like to choose an existing repo (1) or fetch a new repo(2)"
      answer = gets.chomp
      until answer =~ /^[12]$/i
        puts "You have to choose yes (1) or no (2)."
          answer = gets.chomp
        end
          if answer == 1
            prompt("What username would you like to download?", /^\w+$/)
            @username = gets.chomp
          else
            create_new_user
          end
     end
  end
end


# Models for the database
  class User < ActiveRecord::Base
    has_many :contributions
    has_many :repos, through: :contributions
  end

  class Contribution < ActiveRecord::Base
    belongs_to :user
    belongs_to :repo
  end

  class Repo < ActiveRecord::Base
    has_many :contributions
    has_many :users, through: :contributions
  end



# app = Commitchamp::App.new
binding.pry
# Run the following on command line to run code: OAUTH_TOKEN=mySecretKey ruby lib/commitchamp.rb`
