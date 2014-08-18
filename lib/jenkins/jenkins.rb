require 'httparty'
require 'digest'
require_relative 'job'

module Jenkins

  class Jenkins
    include HTTParty

    def initialize(cache, config)
      @cache = cache
      @config = config
    end

    def jobs
      jobs = @cache.get(cache_id 'jobs') do
        get("#{base_view_url}/api/json")
      end

      jobs['jobs'].map do |job|
        Job.new self, job['name'], job['url'], job['color']
      end
    end

    private

    def get(path)
      self.class.get("#{path}", options)
    end

    def base_view_url
      "/view/#{@config['view'] || ''}"
    end

    def options
      { :base_uri => @config['host'] }
          .merge(auth_options)
    end

    def cache_prefix
      "jenkins #{@config['host']}#{base_view_url}"
    end

    def cache_id(id)
      Digest::MD5.hexdigest "#{cache_prefix} #{id}"
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
