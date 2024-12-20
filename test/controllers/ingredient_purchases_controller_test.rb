require "test_helper"

class IngredientPurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient_purchase = ingredient_purchases(:one)
  end

  test "should get index" do
    get ingredient_purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_purchase_url
    assert_response :success
  end

  test "should create ingredient_purchase" do
    assert_difference("IngredientPurchase.count") do
      post ingredient_purchases_url, params: { ingredient_purchase: { purchased_on: @ingredient_purchase.purchased_on, source: @ingredient_purchase.source, total_cost: @ingredient_purchase.total_cost, total_quantity_oz: @ingredient_purchase.total_quantity_oz } }
    end

    assert_redirected_to ingredient_purchase_url(IngredientPurchase.last)
  end

  test "should show ingredient_purchase" do
    get ingredient_purchase_url(@ingredient_purchase)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_purchase_url(@ingredient_purchase)
    assert_response :success
  end

  test "should update ingredient_purchase" do
    patch ingredient_purchase_url(@ingredient_purchase), params: { ingredient_purchase: { purchased_on: @ingredient_purchase.purchased_on, source: @ingredient_purchase.source, total_cost: @ingredient_purchase.total_cost, total_quantity_oz: @ingredient_purchase.total_quantity_oz } }
    assert_redirected_to ingredient_purchase_url(@ingredient_purchase)
  end

  test "should destroy ingredient_purchase" do
    assert_difference("IngredientPurchase.count", -1) do
      delete ingredient_purchase_url(@ingredient_purchase)
    end

    assert_redirected_to ingredient_purchases_url
  end
end
