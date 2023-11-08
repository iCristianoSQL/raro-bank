require 'rails_helper'
RSpec.describe Fee do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.name = "Fee Name"
    subject.value = 50
    subject.latest_release = Date.today
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.value = 50
    subject.latest_release = Date.today
    expect(subject).to_not be_valid
  end

  it "is not valid with a name longer than 100 characters" do
    subject.name = "a" * 101
    subject.value = 50
    subject.latest_release = Date.today
    expect(subject).to_not be_valid
  end

  it "is not valid with a duplicate name" do
    Fee.create(name: "Fee Name", value: 50, latest_release: Date.today)
    subject.name = "Fee Name"
    subject.value = 50
    subject.latest_release = Date.today
    expect(subject).to_not be_valid
  end

  it "is not valid without a value" do
    subject.name = "Fee Name"
    subject.latest_release = Date.today
    expect(subject).to_not be_valid
  end

  it "is not valid with a value outside of 0..100" do
    subject.name = "Fee Name"
    subject.value = 101
    subject.latest_release = Date.today
    expect(subject).to_not be_valid
  end

  it "is not valid without a latest_release date" do
    subject.name = "Fee Name"
    subject.value = 50
    expect(subject).to_not be_valid
  end
end
