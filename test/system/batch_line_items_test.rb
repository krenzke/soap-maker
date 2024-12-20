require "application_system_test_case"

class BatchLineItemsTest < ApplicationSystemTestCase
  setup do
    @batch_line_item = batch_line_items(:one)
  end

  test "visiting the index" do
    visit batch_line_items_url
    assert_selector "h1", text: "Batch line items"
  end

  test "should create batch line item" do
    visit batch_line_items_url
    click_on "New batch line item"

    fill_in "Quantity oz", with: @batch_line_item.quantity_oz
    click_on "Create Batch line item"

    assert_text "Batch line item was successfully created"
    click_on "Back"
  end

  test "should update Batch line item" do
    visit batch_line_item_url(@batch_line_item)
    click_on "Edit this batch line item", match: :first

    fill_in "Quantity oz", with: @batch_line_item.quantity_oz
    click_on "Update Batch line item"

    assert_text "Batch line item was successfully updated"
    click_on "Back"
  end

  test "should destroy Batch line item" do
    visit batch_line_item_url(@batch_line_item)
    click_on "Destroy this batch line item", match: :first

    assert_text "Batch line item was successfully destroyed"
  end
end
