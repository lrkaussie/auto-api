require 'rest-client'
require 'json'
require 'rspec'
require 'date'
require 'active_support/all'
require 'faker'
require_relative '../../support/spec_helper'




describe "enrol_loyalty_and_redeem" do
  cust_id = '1'
  loyalty_vouchers = []
  country = Shim.set_country('my')

  it "should enrol successfully for a new user" do
    json_obj = Shim.enrol_customer
    cust_id = json_obj["id"]
    expect(json_obj["first_name"]).to include("Don")
    expect(json_obj["last_name"]).to include("Enrol")
    expect(((json_obj["memberships"][0]["points"])).to_f).to eq(0.0)
    expect(json_obj["memberships"][0]["country"]).to include("my")
    expect(json_obj["memberships"][0]["name"]).to include("LOYALTY")
  end

  it "should be able to get the welcome and birthday voucher" do
    #below sleep is to wait for the system to generate vouchers
    Utilities.default_sleep_timer
    json_obj = Shim.get_voucher_list(cust_id)
    loyalty_vouchers = json_obj.collect {|x| x["code"]}
    expect(loyalty_vouchers.count).to eq 2
  end

  it "should be able to bulk present the welcome and birthday voucher" do
    json_obj = Shim.bulk_present_vouchers(loyalty_vouchers)
    expect(json_obj[0]["code"]).to include("#{loyalty_vouchers[0]}")
    expect(json_obj[1]["code"]).to include("#{loyalty_vouchers[1]}")
    expect(json_obj[0]["status"]).to include("Voucher Presented")
    expect(json_obj[1]["status"]).to include("Voucher Presented")
  end

    it "should be able to bulk redeem vouchers" do
    json_obj = Shim.bulk_redeem_vouchers(loyalty_vouchers)
    expect(json_obj[0]["code"]).to include("#{loyalty_vouchers[0]}")
    expect(json_obj[1]["code"]).to include("#{loyalty_vouchers[1]}")
    expect(json_obj[0]["status"]).to include("Voucher Redeemed")
    expect(json_obj[1]["status"]).to include("Voucher Redeemed")
  end

  it "should display error message - vouchers already redeemed" do
    json_obj = Shim.bulk_redeem_vouchers(loyalty_vouchers)
    expect(json_obj[0]["code"]).to include("#{loyalty_vouchers[0]}")
    expect(json_obj[1]["code"]).to include("#{loyalty_vouchers[1]}")
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include("70134")
    expect(json_obj[1]["errors"][0]["errorNumber"]).to include("70134")
  end


end

