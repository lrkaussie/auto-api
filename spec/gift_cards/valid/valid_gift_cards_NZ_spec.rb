require 'rest-client'
require 'json'
require 'rspec'
require 'date'
require 'active_support/all'
require 'faker'
require_relative '../../support/spec_helper'
require_relative '../../support/card_info'




describe "gift_cards_verify" do
  country = 'nz'
  set_country = Shim.set_country('nz')
  gift_card_info = GiftCardsinfo.get_giftcardsinfo country

  it "should get issued status for gift card" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['issue_data_1']['code'], @gc_info['issue_data_1']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_1']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_1']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_1']['amount']
  end
  it "should get cancelled status for gift card" do
    # @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(gift_card_info['issue_data_2']['code'], gift_card_info['issue_data_2']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_2']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_2']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_2']['amount']
  end

  it "should get issued status for gift card" do
    # @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(gift_card_info['issue_data_3']['code'], gift_card_info['issue_data_3']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_3']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_3']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_3']['amount']
  end

  it "should get issued status for gift card" do
    # @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(gift_card_info['issue_data_4']['code'], gift_card_info['issue_data_4']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_4']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_4']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_4']['amount']
  end

  it "should get issued status for gift card" do
    # @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(gift_card_info['issue_data_5']['code'], gift_card_info['issue_data_5']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_5']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_5']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_5']['amount']
  end
  it "should get issued status for gift card" do
    # @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(gift_card_info['issue_data_6']['code'], gift_card_info['issue_data_6']['pin'])
    expect(json_obj[0]["status"]).to include gift_card_info['issue_data_6']['status']
    expect(json_obj[0]["currency"]).to include gift_card_info['issue_data_6']['currency']
    expect(json_obj[0]["amount"]).to eq gift_card_info['issue_data_6']['amount']
  end

end

