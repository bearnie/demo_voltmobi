require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :email => "user1@mail.com",
        :name => "Name",
        :login => "Login",
        :password => "password",
      ),
      User.create!(
        :email => "user2@mail.com",
        :name => "Name",
        :login => "Login",
        :password => "password",
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => /.+@mail.com/, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Login".to_s, :count => 2
  end
end
