#encoding: utf-8
require 'spec_helper'

describe CatalogThis do
  it "have an index" do
    get '/'
    last_response.should be_ok
  end

  context 'post catalog/' do
    before(:all) { post 'catalog/', link: 'http://github.com/rails/rails' }
    
    it "receives OK response" do     
      last_response.should be_ok      
    end

    it "receives a valid JSON" do
      expect { JSON.parse(last_response.body) }.to_not raise_error
    end

    it "receives correct parsed JSON" do
      parsed_info = {'site' => 'github.com', 
                    'title' => 'rails/rails · GitHub',
                    'keywords' => 'wip',
                    'url' => 'http://github.com/rails/rails'}
      response_hash = JSON.parse(last_response.body)
      response_hash.should eq(parsed_info)
    end
  end

  


end