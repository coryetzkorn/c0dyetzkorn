# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like
class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    # Consumer details come from registering an app at https://dev.twitter.com/
    # Once you have consumer details, use "ebooks auth" for new access tokens
    self.consumer_key = ENV['TWITTER_CONSUMER_KEY'] # Your app consumer key
    self.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] # Your app consumer secret

    # Users to block instead of interacting with
    self.blacklist = []

    # Range in seconds to randomize delay when bot.delay is called
    self.delay_range = 1..6
  end

  def on_startup
    @model ||= Ebooks::Model.load('model/coryetzkorn.model')
    scheduler.every '1m' do
      tweet(@model.make_statement)
    end
    # # 80% chance to tweet every 2 hours
    # bot.scheduler.every '2h' do
    #   if rand <= 0.8
    #     bot.tweet @model.make_statement
    #   end
    # end
  end

end

# Make a MyBot and attach it to an account
MyBot.new("c0dyetzkorn") do |bot|
  bot.access_token = ENV['TWITTER_ACCESS_TOKEN'] # Token connecting the app to this account
  bot.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET'] # Secret connecting the app to this account
end