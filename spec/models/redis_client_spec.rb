require_relative '../spec_helper'

describe "RedisClient" do
  let(:subject) { RedisClient.instance }
  context "in a fresh Redis instance" do
    context "#get" do
      it "returns false" do
        subject.get('test').should be_false
      end
    end

    context "#count_keys" do
      it "returns 0 keys" do
        subject.count_keys.should be_eql(0)
      end
    end

    context "#keys" do
      it "returns no key" do
        subject.keys.should be_empty
      end
    end
  end

  context "on a filled database" do

    context "#set" do
      it "save a new key and return true" do
        subject.set('test',{derp: 'hello'}).should be_true
      end
    end

    context "#get" do
      it "return false when key is not found" do
        subject.get('not_really_a_key').should be_false
      end

      it "return key's value when found a key" do
        subject.set('test',{derp: 'hello'})
        subject.get('test').class.should eq(Hash)
      end
    end

    context "#exists" do
       it "return true when key is found" do
        subject.set('test',{derp: 'hello'}).should be_true
        subject.exists('test').should be_true
      end
    end

  end

end
