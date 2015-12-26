require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    @executor = FactoryGirl.create :user
    @author = FactoryGirl.create :user
    sign_in @author
    assign(:task, Task.new(
      :name => "MyString",
      :description => "MyString",
      :executor => @executor,
      :author => @author
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_name[name=?]", "task[name]"

      assert_select "textarea#task_description[name=?]", "task[description]"
    end
  end
end
