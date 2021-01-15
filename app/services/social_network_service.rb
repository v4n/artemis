class SocialNetworkService
  BASE_URL = "https://#{Artemis::Application.config.social_network_domain}"

  def initialize(provider)
    @provider = provider
  end

  def call
    result = HTTParty.get("#{BASE_URL}/#{@provider}", timeout: timeout)
  rescue HTTParty::Error => e
    return cached_data
  else
    return cached_data unless result.success?
    
    data = JSON.parse(result.body)
    Rails.cache.write(@provider, data)
    data
  end

  private

  # If we don't have a cached value, we'll give this request a chance to go longer
  def timeout
    Rails.cache.exist?(@provider) ?  
      Constants::RequestTimeouts::SHORT_SECONDS : 
      Constants::RequestTimeouts::LONG_SECONDS
  end
  
  def cached_data
    Rails.cache.read(@provider) || []
  end
end