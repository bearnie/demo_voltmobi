require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    @user = FactoryGirl.create :user
    assign(:tasks, [
      Task.create!(
        :name => "Name",
        :description => "Description",
        :user => @user
      ),
      Task.create!(
        :name => "Name",
        :description => "Description",
        :user => @user
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => @user.email, :count => 2
  end
end
