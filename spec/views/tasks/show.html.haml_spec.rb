require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  before(:each) do
    @user = FactoryGirl.create :user
    sign_in @user
    @task = assign(:task, Task.create!(
      :name => "Name",
      :description => "Description",
      :user => @user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
  end
end
