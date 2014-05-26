require_relative '../spec_helper'

describe Link do
  context ".find" do
    context "with no links catalogged" do
      it "return false" do
        Link.find('teste').should be_false
      end
    end
  end
end
