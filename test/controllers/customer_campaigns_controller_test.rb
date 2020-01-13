require 'test_helper'

class CustomerCampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_campaign = customer_campaigns(:one)
  end

  test "should get index" do
    get customer_campaigns_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_campaign_url
    assert_response :success
  end

  test "should create customer_campaign" do
    assert_difference('CustomerCampaign.count') do
      post customer_campaigns_url, params: { customer_campaign: { campaign_id: @customer_campaign.campaign_id, custcode: @customer_campaign.custcode, custname: @customer_campaign.custname } }
    end

    assert_redirected_to customer_campaign_url(CustomerCampaign.last)
  end

  test "should show customer_campaign" do
    get customer_campaign_url(@customer_campaign)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_campaign_url(@customer_campaign)
    assert_response :success
  end

  test "should update customer_campaign" do
    patch customer_campaign_url(@customer_campaign), params: { customer_campaign: { campaign_id: @customer_campaign.campaign_id, custcode: @customer_campaign.custcode, custname: @customer_campaign.custname } }
    assert_redirected_to customer_campaign_url(@customer_campaign)
  end

  test "should destroy customer_campaign" do
    assert_difference('CustomerCampaign.count', -1) do
      delete customer_campaign_url(@customer_campaign)
    end

    assert_redirected_to customer_campaigns_url
  end
end
