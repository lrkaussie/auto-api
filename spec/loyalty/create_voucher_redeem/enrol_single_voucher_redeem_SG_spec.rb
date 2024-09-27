require 'rest-client'
require 'json'
require 'rspec'
require 'date'
require 'active_support/all'
require 'faker'
require_relative '../../support/spec_helper'




describe "enrol_loyalty_and_redeem" do
  cust_id = '1'
  loyalty_voucher = []
  country = Shim.set_country('sg')

  it "should enrol successfully for a new user" do
    json_obj = Shim.enrol_customer
    cust_id = json_obj["id"]
    expect(json_obj["first_name"]).to include("Don")
    expect(json_obj["last_name"]).to include("Enrol")
    expect(((json_obj["memberships"][0]["points"])).to_f).to eq(0.0)
    expect(json_obj["memberships"][0]["country"]).to include("sg")
    expect(json_obj["memberships"][0]["name"]).to include("LOYALTY")
  end

  it "should be able to get the welcome and birthday voucher" do
    #below sleep is to wait for the system to generate vouchers
    Utilities.default_sleep_timer
    json_obj = Shim.get_voucher_list(cust_id)
    loyalty_voucher = json_obj.collect {|x| x["code"]}
    expect(loyalty_voucher.count).to eq 2
  end

  it "should be able to single present the voucher" do
    json_obj = Shim.single_present_voucher(loyalty_voucher[0])
    expect(json_obj["code"]).to include("#{loyalty_voucher[0]}")
    expect(json_obj["status"]).to include("Voucher Presented")

  end

  it "should be able to single un present the voucher" do
    json_obj = Shim.single_unpresent_voucher(loyalty_voucher[0])
    expect(json_obj["code"]).to include("#{loyalty_voucher[0]}")
    expect(json_obj["status"]).to include("Voucher Available")
    end

  it "should be able to single present the voucher" do
    json_obj = Shim.single_present_voucher(loyalty_voucher[0])
    expect(json_obj["code"]).to include("#{loyalty_voucher[0]}")
    expect(json_obj["status"]).to include("Voucher Presented")

  end


  it "should be able to single redeem vouchers" do
    json_obj = Shim.single_redeem_voucher(loyalty_voucher[0])
    expect(json_obj["code"]).to include("#{loyalty_voucher[0]}")
    expect(json_obj["status"]).to include("Voucher Redeemed")

  end

end

