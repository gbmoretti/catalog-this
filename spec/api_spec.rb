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

  context 'get info' do
    context 'without any link catalogged' do
      before(:all) { get 'info/' }

      it "receives OK response" do
        last_response.should be_ok
      end

      it "receives 0 total links" do
        parsed_info = {'links' => 0}
        response_hash = JSON.parse(last_response.body)

        response_hash.should eq(parsed_info)
      end
    end
    context "with links catalogged" do
      before(:all) do
        post 'catalog/', link: 'http://github.com/innvent/parsley_simple_form'
        get 'info/'
      end

      it "receives OK response" do
        last_response.should be_ok
      end

      it "receives 1 total links" do
        parsed_info = {'links' => 1}
        response_hash = JSON.parse(last_response.body)

        response_hash.should eq(parsed_info)
      end
    end
  end

  context 'get search' do
    it "receives OK response" do
      get 'search/', site: 'github'
      last_response.should be_ok
    end

    it "search non-catalogged site" do
      get 'search/', url: 'http://github.com/innvent/parsley_simple_form'
      response_hash = JSON.parse(last_response.body)
      response_hash.should have(0).item
    end

    it "search by site" do
      post 'catalog/', link: 'http://github.com/innvent/parsley_simple_form'
      get 'search/', site: 'github.com'
      response_hash = JSON.parse(last_response.body)
      response_hash.should have(1).item
    end

    it "search by url" do
      post 'catalog/', link: 'http://github.com/innvent/parsley_simple_form'
      get 'search/', url: 'http://github.com/innvent/parsley_simple_form'
      response_hash = JSON.parse(last_response.body)
      response_hash.should have(1).item
    end
  end
end
