require 'rest-client'
require 'json'
require 'rspec'
require 'date'
require 'active_support/all'
require 'faker'
require_relative '../../support/spec_helper'
require_relative '../../support/card_info'




describe "gift_cards_verify" do
  country = 'au'
  set_country = Shim.set_country('au')
  gift_card_info = GiftCardsinfo.get_giftcardsinfo country

  it "should display error for invalid gift card - it doesnot belong to same  country" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_1']['code'], @gc_info['invalid_data_1']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_1']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_1']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_1']["errorSource"]
  end

  it "should display error for invalid gift code - card number prefix is not correct" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_2']['code'], @gc_info['invalid_data_2']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_2']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_2']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_2']["errorSource"]
  end

  it "should display error for invalid gift code - pin number not correct" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_3']['code'], @gc_info['invalid_data_3']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_3']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_3']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_3']["errorSource"]
  end

  it "should display error for invalid gift code - empty card number" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_4']['code'], @gc_info['invalid_data_4']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_4']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_4']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_4']["errorSource"]
  end
  it "should display error for invalid gift code - invalid pin number" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_5']['code'], @gc_info['invalid_data_5']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_5']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_5']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_5']["errorSource"]
  end
  it "should display error for invalid gift code - empty pin number" do
    @gc_info = GiftCardsinfo.get_giftcardsinfo country
    json_obj = Shim.get_gift_card_details(@gc_info['invalid_data_6']['code'], @gc_info['invalid_data_6']['pin'])
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include (gift_card_info['invalid_data_6']["errorNumber"]).to_s
    expect(json_obj[0]["errors"][0]["errorMessage"]).to include gift_card_info['invalid_data_6']["errorMessage"]
    expect(json_obj[0]["errors"][0]["errorSource"]).to include gift_card_info['invalid_data_6']["errorSource"]
  end
end

