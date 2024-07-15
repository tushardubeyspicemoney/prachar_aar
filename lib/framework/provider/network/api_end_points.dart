class ApiEndPoints {
  ///Product

  static String apiVerifySession = "/get_sessionid";
  static String getCampaign = "/get_campaign";
  static String getIndustrylist = "/get_industrylist";
  static String updateIndustry = "/update_industry";
  static String getOffersByIndustry = "/get_offers";
  static String savebanner = "/save_banner";
  static String getBannerList = "/get_banners";
  static String updateUserBanner = "/save_banner";

  /// Phase 1 CR

  static String getUserIndustry = "/v2/get_user_industry";
  static String getOfferText = "/v2/get_offers";
  static String getUserImages = "/v2/get_user_images";
  static String savePoster = "/v2/save_banner";
  static String getUserPosters = "/v2/get_banners";
  static String uploadImage = "/v2/upload_user_image";
  static String editAddress = "/v2/update_contact";
  static String getFaq = "/v2/get_faq";

  //phase 2
  static String deleteBanner = "/delete_banner";
}
