require "application_system_test_case"

class IngredientPurchasesTest < ApplicationSystemTestCase
  setup do
    @ingredient_purchase = ingredient_purchases(:one)
  end

  test "visiting the index" do
    visit ingredient_purchases_url
    assert_selector "h1", text: "Ingredient purchases"
  end

  test "should create ingredient purchase" do
    visit ingredient_purchases_url
    click_on "New ingredient purchase"

    fill_in "Purchased on", with: @ingredient_purchase.purchased_on
    fill_in "Source", with: @ingredient_purchase.source
    fill_in "Total cost", with: @ingredient_purchase.total_cost
    fill_in "Total quantity oz", with: @ingredient_purchase.total_quantity_oz
    click_on "Create Ingredient purchase"

    assert_text "Ingredient purchase was successfully created"
    click_on "Back"
  end

  test "should update Ingredient purchase" do
    visit ingredient_purchase_url(@ingredient_purchase)
    click_on "Edit this ingredient purchase", match: :first

    fill_in "Purchased on", with: @ingredient_purchase.purchased_on
    fill_in "Source", with: @ingredient_purchase.source
    fill_in "Total cost", with: @ingredient_purchase.total_cost
    fill_in "Total quantity oz", with: @ingredient_purchase.total_quantity_oz
    click_on "Update Ingredient purchase"

    assert_text "Ingredient purchase was successfully updated"
    click_on "Back"
  end

  test "should destroy Ingredient purchase" do
    visit ingredient_purchase_url(@ingredient_purchase)
    click_on "Destroy this ingredient purchase", match: :first

    assert_text "Ingredient purchase was successfully destroyed"
  end
end
