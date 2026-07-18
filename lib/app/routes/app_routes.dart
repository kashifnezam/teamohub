abstract class Routes {
  Routes._();

  // ---------------- Common ----------------

  static const splash = '/';
  static const appEntry = '/app';

  // ---------------- Authentication ----------------

  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';

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
