
class Cache
  def initialize(timeout = 60)
    @timeout = timeout
    @cache = {}
  end

  def get(key, &block)
    return @cache[key][:value] if valid?(key)

    value = block.call

    set(key, value)
  end

  private

  def set(key, value)
    @cache[key] = {
        :expires => @timeout + Time.new.to_i,
        :value => value
    }

    value
  end

  def valid?(key)
    if @cache.has_key? key
      @cache[key][:expires] >= Time.new.to_i
    else
      false
    end
  end
end
