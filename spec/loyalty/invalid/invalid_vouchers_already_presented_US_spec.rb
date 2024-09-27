require 'rest-client'
require 'json'
require 'rspec'
require 'active_support/all'
require '../spec/support/Shim_Api'
require_relative '../../support/spec_helper'

include Shim

describe "enrol_loyalty_and_redeem" do
  cust_id = '1'
  loyalty_vouchers = []
  country = Shim.set_country('us')

  it "should enrol successfully for a new user" do
    json_obj = Shim.enrol_customer
    cust_id = json_obj["id"]
    expect(json_obj["first_name"]).to include("Don")
    expect(json_obj["last_name"]).to include("Enrol")
    expect(((json_obj["memberships"][0]["points"])).to_f).to eq(0.0)
    expect(json_obj["memberships"][0]["country"]).to include("us")
    expect(json_obj["memberships"][0]["name"]).to include("LOYALTY")
  end

  it "should be able to get the list of vouchers" do
    #below sleep is to wait for the system to generate vouchers
    Utilities.default_sleep_timer
    json_obj = Shim.get_voucher_list(cust_id)
    loyalty_vouchers = json_obj.collect {|x| x["code"]}
  end

  it "should be able to bulk present the welcome and birthday voucher" do
    json_obj = Shim.bulk_present_vouchers(loyalty_vouchers)
    expect(json_obj[0]["code"]).to include("#{loyalty_vouchers[0]}")
    expect(json_obj[1]["code"]).to include("#{loyalty_vouchers[1]}")
    expect(json_obj[0]["status"]).to include("Voucher Presented")
    expect(json_obj[1]["status"]).to include("Voucher Presented")
  end

  it "should successfully give error message vouchers already presented" do
    json_obj = Shim.bulk_present_vouchers(loyalty_vouchers)
    expect(json_obj[0]["code"]).to include("#{loyalty_vouchers[0]}")
    expect(json_obj[1]["code"]).to include("#{loyalty_vouchers[1]}")
    expect(json_obj[0]["errors"][0]["errorNumber"]).to include("70133")
    expect(json_obj[1]["errors"][0]["errorNumber"]).to include("70133")
  end

 end