require 'rest-client'
require 'json'
require 'date'


module Shim

  # @url = "https://shim2-test.aws.cottonon.com"
  @url = "http://shim2-cog-test.aws.cottonon.com:8080"
  @header_full_auth = {:authorization=> "Basic YXBwOjExMTE=", :accept => "application/json",:content_type => "application/json"}
  @header_basic_auth = {:authorization=> "Basic YXBwOjExMTE="}
  @random_no = Time.now.nsec.to_s
  @loyalty_email = "cottononqa" + "#{@random_no}" + "@gmail.com"
  @different_email = "cottonon" + "#{@random_no}" + "@gmail.com"
  @dob = 20.years.ago(Date.today).strftime("%m-%d-%Y")

  def set_country(country)
    case country
      when 'au'
        @store = "3995"
        @invalid_store = "0824"
      when 'nz'
        @store = "0818"
        @invalid_store = "0824"
    when 'us'
      @store = "0836"
      @invalid_store = "0824"
    when 'sg'
    @store = "0819"
    @invalid_store = "0824"
    when 'my'
      @store = "0824"
      @invalid_store = "0819"
    end
    end

  def enrol_customer
    post_rest_url_enrol = "#{@url}" + "/api/loyalty/enrol?store=" + "#{@store}"
    json_request = <<END_OF_MESSAGE
{
"email": "#{@loyalty_email}",
"first_name": "Don",
"last_name": "Enrol",
"date_of_birth": "#{@dob}",
"gender": "Male",
"post_code": "3030",
"interests":["Music","Charity","Health","CategoryWomen","CategoryJunior","CategoryStationery"],
"brands":["Body","Cotton On","Typo","Factorie","Kids","Ruby","Supre","Lost","SunnyBuddy"]
}
END_OF_MESSAGE
    resp = RestClient.post(post_rest_url_enrol, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

   def re_enrol_customer
     post_rest_url_enrol = "#{@url}" + "/api/loyalty/enrol?store=" + "#{@store}"
     json_request = <<END_OF_MESSAGE
{
"email": "#{@loyalty_email}",
"first_name": "Don",
"last_name": "Enrol",
"date_of_birth": "",
"gender": "Male",
"post_code": "3030",
"interests":["Music","Charity","Health","CategoryWomen","CategoryJunior","CategoryStationery"],
"brands":["Body","Cotton On","Typo","Factorie","Kids","Ruby","Supre","Lost","SunnyBuddy"]
}
END_OF_MESSAGE
     resp = RestClient.post(post_rest_url_enrol, json_request, @header_full_auth)
     begin
       resp = RestClient.post(post_rest_url_enrol, json_request, @header_full_auth)
     rescue RestClient::ExceptionWithResponse => err
       resp = JSON.parse(err.response)
       return resp
       end
     return JSON.parse(resp)
   end


  def get_voucher_list(cust_id)
    get_rest_url_voucher_list = "#{@url}" +"/api/loyalty/vouchers/list?custId=" + "#{cust_id}" + "&store=" + "#{@store}"
    resp = RestClient.get(get_rest_url_voucher_list, @header_basic_auth)
    return JSON.parse(resp)
  end

  def bulk_present_vouchers(loyalty_vouchers)
    post_rest_url_bulk_present = "#{@url}" + "/api/loyalty/vouchers/present/all?store=" + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_vouchers}"
    resp = RestClient.post(post_rest_url_bulk_present, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

  def single_present_voucher(loyalty_voucher)
    post_rest_url_single_present = "#{@url}" + "/api/loyalty/vouchers/" + "#{loyalty_voucher}" + "/present?store="  + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_voucher}"
    resp = RestClient.post(post_rest_url_single_present, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

  def single_unpresent_voucher(loyalty_voucher)
    post_rest_url_single_unpresent = "#{@url}" + "/api/loyalty/vouchers/" + "#{loyalty_voucher}" + "/unpresent?store="  + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_voucher}"
    resp = RestClient.post(post_rest_url_single_unpresent, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

  def single_redeem_voucher(loyalty_voucher)
    post_rest_url_single_redeem = "#{@url}" + "/api/loyalty/vouchers/" + "#{loyalty_voucher}" + "/redeem?store="  + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_voucher}"
    resp = RestClient.post(post_rest_url_single_redeem, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

   def bulk_present_vouchers_invalid_store(loyalty_vouchers)
     post_rest_url_bulk_present = "#{@url}" + "/api/loyalty/vouchers/present/all?store=" + "#{@invalid_store}" + "&email=" + "#{@loyalty_email}"
     json_request = "#{loyalty_vouchers}"
     begin
       resp = RestClient.post(post_rest_url_bulk_present, json_request, @header_full_auth)
     rescue RestClient::ExceptionWithResponse => err
       resp = JSON.parse(err.response)
       return resp
     end
     return JSON.parse(resp)
   end

  def bulk_unpresent_vouchers(loyalty_vouchers)
    post_rest_url_bulk_unpresent = "#{@url}" + "/api/loyalty/vouchers/unpresent/all?store=" + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_vouchers}"
    resp = RestClient.post(post_rest_url_bulk_unpresent, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

  def bulk_redeem_vouchers(loyalty_vouchers)
    post_rest_url_bulk_redeem = "#{@url}" + "/api/loyalty/vouchers/redeem/all?store=" + "#{@store}" + "&email=" + "#{@loyalty_email}"
    json_request = "#{loyalty_vouchers}"
    resp = RestClient.post(post_rest_url_bulk_redeem, json_request, @header_full_auth)
    return JSON.parse(resp)
  end


    def enrol_customer_without_email_address
     post_rest_url_enrol = "#{@url}" + "/api/loyalty/enrol?store=" + "#{@store}"
     json_request = <<END_OF_MESSAGE
{
"email": "",
"first_name": "",
"last_name": "Enrol",
"date_of_birth": "",
"gender": "Male",
"post_code": "3030",
"interests":["Music","Charity","Health","CategoryWomen","CategoryJunior","CategoryStationery"],
"brands":["Body","Cotton On","Typo","Factorie","Kids","Ruby","Supre","Lost","SunnyBuddy"]
}
END_OF_MESSAGE
     begin
       resp = RestClient.post(post_rest_url_enrol, json_request, @header_full_auth)
     rescue RestClient::ExceptionWithResponse => err
       resp = JSON.parse(err.response)
       return resp
     end
     return JSON.parse(resp)
   end



  def enrol_different_customer
    post_rest_url_enrol = "#{@url}" + "/api/loyalty/enrol?store=" + "#{@store}"
    json_request = <<END_OF_MESSAGE
{
"email": "#{@different_email}",
"first_name": "Different customer",
"last_name": "Enrol",
"date_of_birth": "#{@dob}",
"gender": "Male",
"post_code": "3030",
"interests":["Music","Charity","Health","CategoryWomen","CategoryJunior","CategoryStationery"],
"brands":["Body","Cotton On","Typo","Factorie","Kids","Ruby","Supre","Lost","SunnyBuddy"]
}
END_OF_MESSAGE
    resp = RestClient.post(post_rest_url_enrol, json_request, @header_full_auth)
    return JSON.parse(resp)
   end

  def bulk_present_vouchers_belong_to_different_customer(loyalty_vouchers)
    post_rest_url_bulk_present = "#{@url}" + "/api/loyalty/vouchers/present/all?store=" + "#{@store}" + "&email=" + "#{@different_email}"
    json_request = "#{loyalty_vouchers}"
    resp = RestClient.post(post_rest_url_bulk_present, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

  def get_gift_card_details(code,pin)
    post_rest_url_gift_card_details = "#{@url}" + "/api/rms/vouchers/verify/all?store=" + "#{@store}"
    json_request = <<END_OF_MESSAGE
[
  {
  "code": "#{code}",
  "pin": "#{pin}",
  }
]
END_OF_MESSAGE
    resp = RestClient.post(post_rest_url_gift_card_details, json_request, @header_full_auth)
    return JSON.parse(resp)
  end

end