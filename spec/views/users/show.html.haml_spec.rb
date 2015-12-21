require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user, 
      :email => "user888@gmail.com",
      :name => "Name888",
      :login => "Login888"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/user888@gmail.com/)
    expect(rendered).to match(/Name888/)
  end
end
