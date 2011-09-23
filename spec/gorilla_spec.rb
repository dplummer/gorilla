require 'spec_helper'

describe Gorilla do
  include Goliath::TestHelper

  let(:err) {Proc.new {|c| raise "HTTP Request failed #{c.response}"}}

  it "routes the index" do
    with_api(Gorilla) do
      get_request({}, err) do |c|
        c.response_header.status.should == 200
        c.response.should == "Hello World"
      end
    end
  end

  it "routes the status" do
    with_api(Gorilla) do
      get_request({:path => '/status'}, err) do |c|
        c.response_header.status.should == 200
        c.response.should == "OK"
      end
    end
  end

  it "routes the environment" do
    with_api(Gorilla) do
      get_request({:path => '/env'}, err) do |c|
        c.response_header.status.should == 200
        c.response.should == "test"
      end
    end
  end
end
