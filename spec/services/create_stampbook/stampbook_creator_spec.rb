require "rails_helper"

RSpec.describe CreateStampbook::StampbookCreator, type: :model do

  subject { described_class.new(params: stampbook_params, user: user, location_ids: [location.id]).call }

  let(:stampbook_params) { { stampbook_name: 'Test1', stampbook_description: 'Test1', status: false } }
  let(:user) { FactoryBot.create(:user) }
  let(:location) { FactoryBot.create(:location, user_id: user.id) }


  context "When all the params are correct" do

    it "returns an instance of a Stampbook" do
      expect(subject).to be_an_instance_of(Stampbook)
    end

    it "return the right attributes", :aggregate_failures do
      expect(subject.stampbook_name).to be_a(String)
      expect(subject.status).to eq(false)
    end
  end





end
