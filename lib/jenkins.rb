require 'httparty'

class Jenkins
  include HTTParty

  def initialize(config)
    @config = config
    self.class.base_uri @config['host']
    self.class.basic_auth @config['username'], @config['password']
  end

  def jobs
    self.class.get("#{base_view_url}/api/json")['jobs']
  end

  private

  def base_url
    @config['host']
  end

  def base_view_url
    p "#{base_url}/#{@config['view'] || ''}"
  end

  def options
    { :basic_auth => { :username => @config['username'], :password => @config['password'] } }
  end
end
