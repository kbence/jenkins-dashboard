require 'httparty'

module Jenkins

  class Jenkins
    include HTTParty

    def initialize(config)
      @config = config
    end

    def jobs
      get("#{base_view_url}/api/json")['jobs']
    end

    private

    def get(path)
      self.class.get("#{path}", options)
    end

    def base_view_url
      "/#{@config['view'] || ''}"
    end

    def options
      { :base_uri => @config['host'] }
          .merge(auth_options)
    end

    def auth_options
      case @config['auth']
      when 'basic'
        {
          :basic_auth => {
            :username => @config['username'],
            :password => @config['password']
          }
        }
      when 'digest'
        {
          :digest_auth => {
            :username => @config['username'],
            :password => @config['password']
          }
        }
      else
        {}
      end
    end
  end

end
