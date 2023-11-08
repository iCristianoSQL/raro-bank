 require 'rails_helper'

describe User do
  subject { described_class.new(name: "John Doe", cpf: "12355678900") }

    context "validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:cpf) }
      it { should validate_uniqueness_of(:cpf).case_insensitive }
      it { should validate_length_of(:cpf).is_equal_to(11) }
    end

    describe "associations" do
      it { should have_one(:balance) }
      it { should have_one(:administrator) }
      it { should have_many(:sent_transfers).class_name("Transfer").with_foreign_key("sender_id") }
      it { should have_many(:received_transfers).class_name("Transfer").with_foreign_key("receiver_id") }
    end


 end

