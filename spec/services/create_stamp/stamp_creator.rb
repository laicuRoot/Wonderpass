require "rails_helper"

RSpec.describe CreateStamp::StampCreator, type: :model do
  subject { described_class.new(location_id: location.id, stampbook_id: stampbook.id).call }

  let(:stampbook) { FactoryBot.create(:stampbook, user: user) }
  let(:user) { FactoryBot.create(:user) }
  let(:location) { FactoryBot.create(:location, user: user) }

  it "returns an instance of a Stamp" do
    expect(subject).to be_an_instance_of(Stamp)
  end

end
