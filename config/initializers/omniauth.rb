Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  end

  #Here's an example for adding the middleware to a Rails app in config/initializers/omniauth.rb:
  #in Chris's video, he does config/init/github.rb, variance OK.