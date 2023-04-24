require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  it "should validate that it's a properly formatted email" do
    poppy = User.new(email: "popy_rocky_road@gmail.com", password: "password", password_confirmation: "password")

    expect(poppy.valid?).to be(true)
    
    poppy = User.new(email: "fasd324223", password: "password", password_confirmation: "password")
    expect(poppy.valid?).to be(false)
  end

  it ".set_api_key" do
    poppy = User.new(email: "popy_rocky_road@gmail.com", password: "password", password_confirmation: "password")
    expect(poppy.send(:set_api_key)).to be_a(String)
  end
end
