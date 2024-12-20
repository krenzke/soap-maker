require "test_helper"

class BatchLineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batch_line_item = batch_line_items(:one)
  end

  test "should get index" do
    get batch_line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_batch_line_item_url
    assert_response :success
  end

  test "should create batch_line_item" do
    assert_difference("BatchLineItem.count") do
      post batch_line_items_url, params: { batch_line_item: { quantity_oz: @batch_line_item.quantity_oz } }
    end

    assert_redirected_to batch_line_item_url(BatchLineItem.last)
  end

  test "should show batch_line_item" do
    get batch_line_item_url(@batch_line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_batch_line_item_url(@batch_line_item)
    assert_response :success
  end

  test "should update batch_line_item" do
    patch batch_line_item_url(@batch_line_item), params: { batch_line_item: { quantity_oz: @batch_line_item.quantity_oz } }
    assert_redirected_to batch_line_item_url(@batch_line_item)
  end

  test "should destroy batch_line_item" do
    assert_difference("BatchLineItem.count", -1) do
      delete batch_line_item_url(@batch_line_item)
    end

    assert_redirected_to batch_line_items_url
  end
end
