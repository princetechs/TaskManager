require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        new: "New",
        create: "Create"
      ),
      Task.create!(
        new: "New",
        create: "Create"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: "New".to_s, count: 2
    assert_select "tr>td", text: "Create".to_s, count: 2
  end
end
