require "minitest_helper"

describe Raphl::Entry do

  describe "the Raphl::Entry class" do
    it "should instantiate" do
      Raphl::Entry.new.must_be_instance_of Raphl::Entry
    end

    it "should have a base key" do
      Raphl::Entry.key.must_equal "entries"
    end

    it "should allow a subkey" do
      Raphl::Entry.key("subkey").must_equal "entries:subkey"
    end

    it "should grab all entries for a raffle" do
      $redis.sadd("entries:entry_test", "entry1")
      $redis.sadd("entries:entry_test", "entry2")

      entries = Raphl::Entry.all("entry_test")
      entries.must_include("entry1")
      entries.must_include("entry2")
    end

    it "should select an entry at random" do
      $redis.sadd("entries:entry_test", "entry1")
      $redis.sadd("entries:entry_test", "entry2")

      entries = Raphl::Entry.all("entry_test")
      Raphl::TrueRandom.stub :select, entries.first do
        Raphl::Entry.select(entries).must_equal entries.first
      end
    end
  end

  describe "a Raphl::Entry instance" do
    before do
      @entry = Raphl::Entry.new({
        email: "test@example.com",
        raffle: "entry_test",
        terms: true
      })
    end

    it "should have a key for the raffle" do
      @entry.key.must_equal("entries:entry_test")
    end

    it "should be valid" do
      @entry.valid?.must_equal true
    end

    it "should save to redis" do
      @entry.save
      Raphl::Entry.all(@entry.raffle).must_include(@entry.email)
    end
  end

end
