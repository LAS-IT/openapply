require "spec_helper"

RSpec.describe Openapply::Version do

  context "version check" do

    it "has a version number" do
      expect(Openapply::Version::VERSION).not_to be nil
    end
    it "has correct version number" do
      expect(Openapply::Version::VERSION).to eq "0.4.0"
    end

  end

end
