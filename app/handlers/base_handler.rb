class BaseHandler
  include Rails.application.routes.url_helpers
  include Telegram::Bot::Types

  attr_accessor :telegram_profile

  def initialize(telegram_profile)
    @telegram_profile = telegram_profile
  end

  def telegram_api
    Rails.configuration.telegram_bot.api
  end
end