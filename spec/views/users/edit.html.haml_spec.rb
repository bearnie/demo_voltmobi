require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @admin = FactoryGirl.create :admin
    sign_in @admin
    @user = FactoryGirl.create :user
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_disabled[name=?]", "user[disabled]"
    end
  end
end
