require 'sinatra'
require 'httparty'
require 'json'
require './lib/yaml_config'
require './lib/jenkins'

class App < Sinatra::Base
  def initialize
    super

    @config = YamlConfig.get
    @jenkins = Jenkins.new @config['jenkins']
  end

  get '/' do
    erb :index, :locals => {
        :jobs => @jenkins.jobs
    }
  end
end
