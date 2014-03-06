require 'spec_helper'

describe CatalogThis do
  it "have an index" do
    get '/'
    last_response.should be_ok
  end

  it "add an site to catalog" do
    post 'catalog/', link: 'http://github.com/rails/rails'
    last_response.should be_ok
  end


end