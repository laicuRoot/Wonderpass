require_relative "../app/models/user"

RSpec.describe "User Model" do
  let(:user) { User.new }

  context "When user doesn't have any arguments" do
    it "should raise an argument error" do
      expect { user }.to raise_error(ArgumentError)
    end
  end
end
