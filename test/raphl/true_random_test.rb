require "minitest_helper"

describe Raphl::TrueRandom do

  before do
    $redis.sadd("entries:true_random_test", "entry1@example.com")
    $redis.sadd("entries:true_random_test", "entry2@example.com")
    $redis.sadd("entries:true_random_test", "entry3@example.com")
    $redis.sadd("entries:true_random_test", "entry3@example.com")

    @entries = Raphl::Entry.all("entry_test")
  end

  it "should select an item from a collection at random" do
    HTTParty.stub :get, "1" do
      Raphl::TrueRandom.select(@entries).must_equal(@entries[1])
    end
  end

  it "should have a fallback method in case random.org is down or the request fails" do
    module HTTParty
      def self.get(*args)
        raise SocketError
      end
    end

    Random.stub :rand, 2 do
      Raphl::TrueRandom.select(@entries).must_equal(@entries[2])
    end
  end
end

