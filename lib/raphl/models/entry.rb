module Raphl
  class Entry
    attr_accessor :email, :raffle, :terms

    def initialize(options = {})
      @email = options.fetch(:email) { "" }
      @terms = options.fetch(:terms) { nil }
      @raffle = options.fetch(:raffle) { nil }
    end

    def key
      Entry.key(@raffle)
    end

    def save
      valid? ? Entry.redis.sadd(key, @email) : false
    end

    def valid?
      !!(raffle && terms && !(@email.empty?))
    end

    def self.all(raffle)
      redis.smembers(key(raffle))
    end

    def self.key(subkey = nil)
      key  = "entries"
      key << ":#{ subkey }" if subkey
      key
    end

    def self.redis
      $redis
    end

    def self.select(raffle)
      TrueRandom.select(Entry.all(raffle))
    end

  end
end
