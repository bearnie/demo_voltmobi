require 'rails_helper'

RSpec.describe "tasks/show", type: :view do
  before(:each) do
    @executor = FactoryGirl.create :user
    @author = FactoryGirl.create :user
    sign_in @author
    @task = assign(:task, Task.create!(
      :name => "Name",
      :description => "Description",
      :executor => @executor,
      :author => @author
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
  end
end
