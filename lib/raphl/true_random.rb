module Raphl
  module TrueRandom
    module_function

    # Pick a random element from collection using Random.org true random number generator
    def select(collection = [])
      entry_index = random(0, collection.count-1)
      collection[entry_index]
    end

    def random(min, max)
      true_random(min, max)
    rescue SocketError, ArgumentError
      fallback_random(min, max)
    end

    def fallback_random(min, max)
      Random.rand(min..max)
    end

    def true_random(min, max)
      uri = "http://www.random.org/integers/?col=1&num=1&base=10&format=plain"
      uri << "&min=#{ min }"
      uri << "&max=#{ max }"

      Integer(HTTParty.get(uri))
    end
  end
end
