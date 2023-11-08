require 'rails_helper'

describe Administrator do
  describe "associations" do
    it { should belong_to(:user) }
  end
end
