require "rails_helper"

RSpec.describe CreateStampbook::StampbookDuplicator, type: :model do

  subject { described_class.new(stampbook_id: stampbook.id, user: user).call }

  let(:stampbook) { FactoryBot.create(:stampbook, user_id: user2.id, status: true) }

  let(:user) { FactoryBot.create(:user, email: 'testemail@email.com') }
  let(:user2) { FactoryBot.create(:user, id: 2) }

  context "When stampbook can be cloned" do

    it "returns an instance of a Stampbook" do
      expect(subject).to be_an_instance_of(Stampbook)
    end

  end

end
