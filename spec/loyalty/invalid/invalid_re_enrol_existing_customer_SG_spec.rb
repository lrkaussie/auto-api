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
  country = Shim.set_country('sg')

  it "should display error for existing customer re enrol " do
    json_obj = Shim.re_enrol_customer
    expect(json_obj[0]["errorNumber"]).to include("57311")
  end

end