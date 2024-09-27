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
  country = Shim.set_country('nz')

  it "should display Email address is required field" do
    json_obj = Shim.enrol_customer_without_email_address
    expect(json_obj[0]["errorNumber"]).to include("58103")
  end
end