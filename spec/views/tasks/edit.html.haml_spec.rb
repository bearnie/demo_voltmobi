require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @user = FactoryGirl.create :user
    sign_in @user
    @task = assign(:task, Task.create!(
      :name => "MyString",
      :description => "MyString",
      :user => @user
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_name[name=?]", "task[name]"

      assert_select "textarea#task_description[name=?]", "task[description]"

    end
  end
end
