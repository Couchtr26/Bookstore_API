# config/initializers/devise_rails8_patch.rb
Rails.application.config.after_initialize do
  Devise.setup do |config|
    config.warden do |manager|
      manager.failure_app = Devise::Delegator.new
    end
  end
end
