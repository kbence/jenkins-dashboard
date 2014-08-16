
module Jenkins

  class Job
    attr_reader :name
    attr_reader :url
    attr_reader :status

    def initialize(jenkins, name, url, status)
      @jenkins = jenkins
      @name = name
      @url = url
      @status = JobStatus.new(status)
    end

    def build_url
      p @status.to_s
      if @status.to_s == "unknown"
        @url
      else
        "#{@url}/lastBuild/console"
      end
    end
  end

  class JobStatus
    COLOR_TO_STATUS = {
        :aborted => :aborted,
        :aborted_anime => :aborted,
        :blue => :good,
        :blue_anime => :good,
        :disabled => :disabled,
        :disabled_anime => :disabled,
        :grey => :grey,
        :grey_anime => :grey,
        :notbuilt => :unknown,
        :notbuilt_anime => :unknown,
        :red => :bad,
        :red_anime => :bad,
        :yellow => :unstable,
        :yellow_anime => :unstable,
    }

    def initialize(status_color)
      @status = if COLOR_TO_STATUS.has_key? status_color.to_sym
                  COLOR_TO_STATUS[status_color.to_sym]
                else
                  :unknown
                end
    end

    def to_s
      @status.to_s
    end
  end

end
