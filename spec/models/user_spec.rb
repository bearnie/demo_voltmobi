require 'rails_helper'

RSpec.describe User, type: :model do

  it "is not valid without a email" do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end

  it "is valid with a email" do
    user = User.new(email: "admin@example.com", password: "password")
    expect(user).to be_valid
  end

end
