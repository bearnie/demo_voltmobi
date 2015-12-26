require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    @executor = FactoryGirl.create :user
    @author = FactoryGirl.create :user
    assign(:tasks, [
      Task.create!(
        :name => "Name",
        :description => "Description",
        :executor => @executor,
        :author => @author
      ),
      Task.create!(
        :name => "Name",
        :description => "Description",
        :executor => @executor,
        :author => @author
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    #assert_select "tr>td", :text => @executor.email, :count => 2
    #assert_select "tr>td", :text => @author.email, :count => 2
  end
end
