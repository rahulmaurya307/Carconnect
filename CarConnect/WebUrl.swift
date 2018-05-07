//
//  WebUrl.swift
//  MyTest
//
//  Created by Rahul on 06/11/17.
//  Copyright © 2017 Rahul. All rights reserved.
//

import Foundation
class WebUrl {

    public static let SUCCESS_CODE : String! = "101"
    public static let ERROR_CODE : String! = "102"
    
//    //************************** BASEURL URL **************************
//    private static var BASEURL = "http://car-connect.dev.aritron.in/api/user/"
//
//    //************************** IMAGE URLS **************************
//    public static var  IMAGE_URL = "http://car-connect.dev.aritron.in/images/thumbnail/"
//
//    public static var IMAGE_URL_LARGE = "http://car-connect.dev.aritron.in/images/thumbnail/"
//    public static var  ECOM_IMAGE_URL = "http://ecom.dev.aritron.in/images/thumbnail/"
//
//    public static var  ECOM_IMAGE_URL_LARGE = "http://ecom.dev.aritron.in/images/large/"
//
    
    //************************** BASEURL URL **************************
     private static var BASEURL = "http://globe-car.aritron.in/api/user/"
   // private static var BASEURL = "http://car-connect.test.aritron.in/api/user/"
    
    //************************** IMAGE URLS **************************
    public static var  IMAGE_URL = "http://globe-car.aritron.in/images/thumbnail/"

    public static var IMAGE_URL_LARGE = "http://globe-car.aritron.in/images/thumbnail/"

    public static var  ECOM_IMAGE_URL = "http://globe-car.aritron.in/images/thumbnail/"

    public static var  ECOM_IMAGE_URL_LARGE = "http://globe-ecom.aritron.in/images/large/"

    
    
    public static var  MODEL_IMAGE_URL = IMAGE_URL+"model/"
    
    public static var  USED_CAR_IMAGE_URL = IMAGE_URL+"usedCars/"
    
    public static var  NEWS_IMAGE_URL = IMAGE_URL_LARGE + "news/"
    
    public static var  HELPLINE_IMAGE_URL = IMAGE_URL + "brandhelpline/"
    
    public static var  OFFERS_IMAGE_URL = "http://globe-ecom.aritron.in/images/large/offer/"
    
    public static var  PRODUCT_IMAGE_URL = ECOM_IMAGE_URL_LARGE + "product/"
    
    public static var  NEW_CARS = IMAGE_URL + "model/"
    

    
    //************************** PAGE URLS **************************
    public static var HOME_PAGE_URL = BASEURL + "home"
    
    public static var RECEIPT_AFTER_PAY = BASEURL + "productTransactionhistory"
    
    public static var REGSTATUS = BASEURL + "registrationstatus"
   
    public static var LOGIN_URL = BASEURL + "login"
    
    public static var GET_PROFILE = BASEURL + "getprofile"
    
    public static var FORGOT_PASS_URL = BASEURL + "forgetpassword"
    
    public static var GENERATE_OTP_URL = BASEURL + "generateotp"
    
    public static var RESEND_OTP_URL = BASEURL + "resendotp"
    
    public static var VERIFY_OTP_URL = BASEURL + "verifyotp"
    
    public static var SET_PASSWORD_URL = BASEURL + "setpassword"
    
    public static var NEW_CAR_URL = BASEURL + "getnewcarlist"
    
    public static var MY_CAR_URL = BASEURL + "mycars"
    
    public static var USED_CAR_URL = BASEURL + "usedcarlist"
    
    public static var NEWS_LIST_URL = BASEURL + "newslist"
    
    public static var ROAD_ASSISTANCE_URL = BASEURL + "roadsideastlist"
    
    public static var BRAND_HELPLINE_URL = BASEURL + "brandhelplinelist"
    
    public static var AVAILABLE_POINT_URL = BASEURL + "avialablePoint"
    
     public static var POINT_SUMMARY = BASEURL + "listCustomerTransaction"
    
    public static var  REFERRAL_LIST_URL = BASEURL + "availablereferralList"
    
    public static var  ADD_REFERRAL_URL = BASEURL + "addreferral"
    
    public static var  REFERRAL_HISTORY_URL = BASEURL + "referralhistory"
    
    public static var  REFERRAL_WALKIN_HISTORY_URL = BASEURL + "cardStatusReferralList"
    
    public static var  DEALER_OFFERS_URL = BASEURL + "availableOffers"
    
    public static var  PARTNER_OFFERS_URL = BASEURL + "availablePartnerOffers"
    
    public static var  USED_CAR_DETAIL_LIST_URL = BASEURL + "usedcarsdetails"
    
    public static var  SHOW_INTREST_URL = BASEURL + "showcarinterest"
    
    public static var  NEW_CAR_LIST_URL = BASEURL + "getnewcarlist"
    
    public static var  NEW_CAR_DETAIL_LIST_URL = BASEURL + "newcardetail"
    
    public static var VARIANT_URL = BASEURL + "variantlist"
    
    public static var VARIANT_SPECIFICATION_URL = BASEURL + "getUservariantspecification"
    
    public static var BOOK_TEST_DRIVE_URL = BASEURL + "booktestdrive"
    
    public static var  BRAND_LIST_URL = BASEURL + "brandlist"
    
    public static var  MODEL_LIST_URL = BASEURL + "modellist"
    
    public static var  VARIANT_LIST_URL = BASEURL + "getvariantlist"
    
     public static var COMPARE_LIST_URL = BASEURL + "comparevariant"
    
     public static var CLASSIFIED_LIST_URL = BASEURL + "addclassified"
    
    public static var ADD_LOAN_ASSISTANCE_URL = BASEURL + "addloanassistance"
    
    public static var LOCATION = BASEURL + "locationlist"
    
    
   // addloanassistance
    
/*E COM URL*/
    public static var PRODUCT_LIST_URL = BASEURL + "productlist"
    
    public static var PRODUCT_DETAIL_URL = BASEURL + "productdetail"
    
    public static var ADD_CART_URL = BASEURL + "addproducttocart"
    
    public static var CART_LIST_URL = BASEURL + "cartlist"
    
    public static var DELETE_CART_URL = BASEURL + "deleteProductsFromCart"
    
    public static var UPDATE_CART_URL = BASEURL + "updateproducttocart"
    
    public static var COUPON_LIST_URL = BASEURL + "availableCoupons"
    
    public static var VOUCHER_LIST_URL = BASEURL + "avialablevoucher"
    
    public static var CHECK_OUT_URL = BASEURL + "checkout"
    
    public static var RESERVE_CUSTOMER_ORDER_URL = BASEURL + "reserveCustomerOrder"
    
    public static var CONFIRM_CUSTOMER_ORDER_URL = BASEURL + "confirmCustomerOrder"
    
    public static var DISCARD_CUSTOMER_ORDER_URL = BASEURL + "discardCustomerOrder"
    
    public static var TRANSCATION_HISTORY = BASEURL + "productTransactionhistory"
    
    public static var CLEAR_CART = BASEURL + "deleteCardProductByOrderId"
    
    public static var PARTNER_PRODUCT_LIST = BASEURL + "listPartnerProduct"
    
    public static var ORDER_DETAIL_URL = BASEURL + "getOrderDetail"
    
    public static var SERVICE_TOKEN_URL = BASEURL + "createFcmGroupUser"
    
    public static var  SERVICE_LIST_URL = BASEURL + "servicelist"
    
    public static var BOOK_SERVICE_URL = BASEURL + "bookservice";
    
    public static var INSURANCE_URL = BASEURL + "insurancerenewal";

    public static var COLOR_LIST_URL = BASEURL + "colorlists";
}
