abstract class AppRoutes {
  AppRoutes._();

  // ---------------- Common ----------------

  static const splash = '/';
  static const appEntry = '/app';

  // ---------------- Authentication ----------------

  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';

  // ---------------- Agent ----------------
  static const agent = '/agent';
  static const String agentDashboard = '/agent-dashboard';
  static const String agentClientRequests = '/agent-client-requests';
  static const String agentPromotionRequests = '/agent-promotion-requests';
  static const String agentListings = '/agent-listings';
  static const String agentCreateListing = '/agent-create-listing';
  static const String agentListingShare = '/agent-listing-share';
  static const String agentMyListings = '/agent-my-listings';
  static const String agentAnalytics = '/agent-analytics';
  static const String agentDirectory = '/agent-directory';
  static const String agentProfile = '/agent-profile';
  static const String agentHireRequest = "/agent-hire-request";


  // ---------------- Banner ----------------
  static const bannerManagement = '/banner-management';
  static const bannerForm = '/banner-form';


  // ---------------- Dashboard ----------------

  static const dashboard = '/dashboard';

  // ---------------- Home ----------------

  static const home = '/home';

  // ---------------- Category ----------------

  static const categories = '/categories';
  static const subCategories = '/sub-categories';

  // ---------------- Product ----------------

  static const addProduct = '/add-product';
  static const editProduct = '/edit-product';
  static const productDetails = '/product-details';
  static const myProducts = '/my-products';
  static const productPreview = '/product-preview';
  static const myAds = '/my-ads';

  // ---------------- Chat ----------------

  static const chats = '/chats';
  static const chat = '/chat';

  // ---------------- Favourite ----------------

  static const favourites = '/favourites';

  // ---------------- Profile ----------------

  static const profile = '/profile';
  static const editProfile = '/edit-profile';

  // ---------------- Search ----------------

  static const search = '/search';

  // ---------------- Notification ----------------

  static const notifications = '/notifications';

  // ---------------- Settings ----------------

  static const settings = '/settings';

  // ---------------- Location ----------------

  static const locationPicker = "/location-picker";
}
