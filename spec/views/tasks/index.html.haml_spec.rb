require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    @executor = FactoryGirl.create :user
    @author = FactoryGirl.create :user
    tasks = [
      FactoryGirl.create(
        :task,
        :name => "Name",
        :description => "Description",
        :executor => @executor,
        :author => @author
      ),
      FactoryGirl.create(
        :task,
        :name => "Name",
        :description => "Description",
        :executor => @executor,
        :author => @author
      )
    ]
    tasks = Kaminari.paginate_array(tasks).page(1)
    assign(:tasks, tasks)
  end

  it "renders a list of tasks" do
    render
    assert_select "div.task div.task_content", :text => "Name".to_s, :count => 2
  end
end
