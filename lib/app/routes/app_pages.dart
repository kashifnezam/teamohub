import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:teamomarket/modules/favourite/views/favourite_page.dart';
import 'package:teamomarket/modules/home/bindings/dashboard_binding.dart';
import 'package:teamomarket/modules/home/views/dashboard_screen.dart';
import 'package:teamomarket/modules/my_ads/bindings/my_ads_binding.dart';
import 'package:teamomarket/modules/my_ads/views/my_ads_page.dart';
import 'package:teamomarket/modules/product/views/product_preview_page.dart';
import 'package:teamomarket/modules/product/views/product_search_page.dart';
import 'package:teamomarket/modules/profile/bindings/profile_binding.dart';
import 'package:teamomarket/modules/profile/views/profile_page.dart';
import '../../modules/agent/bindings/agent_analytics_binding.dart';
import '../../modules/agent/bindings/agent_binding.dart';
import '../../modules/agent/bindings/agent_client_requests_binding.dart';
import '../../modules/agent/bindings/agent_create_listing_binding.dart';
import '../../modules/agent/bindings/agent_dashboard_binding.dart';
import '../../modules/agent/bindings/agent_directory_binding.dart';
import '../../modules/agent/bindings/agent_hire_request_binding.dart';
import '../../modules/agent/bindings/agent_listing_share_binding.dart';
import '../../modules/agent/bindings/agent_my_listings_binding.dart';
import '../../modules/agent/bindings/agent_profile_binding.dart';
import '../../modules/agent/bindings/agent_promotion_requests_binding.dart';
import '../../modules/agent/views/agent_directory_view.dart';
import '../../modules/agent/views/agent_hire_request_view.dart';
import '../../modules/agent/views/agent_profile_view.dart';
import '../../modules/agent/views/analytics/agent_analytics_view.dart';
import '../../modules/agent/views/become_agent_view.dart';
import '../../modules/agent/views/dashboard/agent_dashboard_view.dart';
import '../../modules/agent/views/listings/agent_create_listing_view.dart';
import '../../modules/agent/views/listings/agent_listing_share_view.dart';
import '../../modules/agent/views/listings/agent_my_listings_view.dart';
import '../../modules/agent/views/promotions/agent_promotion_requests_view.dart';
import '../../modules/agent/views/requests/agent_client_requests_view.dart';
import '../../modules/auth/views/login_screen.dart';
import '../../modules/auth/views/signup_view.dart';
import '../../modules/banner/bindings/banner_binding.dart';
import '../../modules/banner/views/banner_form_page.dart';
import '../../modules/banner/views/banner_management_page.dart';
import '../../modules/category/bindings/category_binding.dart';
import '../../modules/category/views/categories_page.dart';
import '../../modules/category/views/sub_category_page.dart';
import '../../modules/chat/bindings/chat_binding.dart';
import '../../modules/chat/views/chat_list_page.dart';
import '../../modules/chat/views/chats_page.dart';
import '../../modules/location/bindings/location_binding.dart';
import '../../modules/location/views/location_picker_page.dart';
import '../../modules/product/views/add_product_page.dart';
import '../../modules/splash/views/splashscreen.dart';
import 'app_routes.dart';
import 'middlewares/auth_guard.dart';
import 'middlewares/role_redirect_middleware.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: AppRoutes.appEntry,
      page: () => const SizedBox(),
      middlewares: [
        RoleRedirectMiddleware(),
      ],
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () =>  SignupView(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () =>  AuthenticationView(),
    ),


    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),


    GetPage(
      name: AppRoutes.dashboard,
      page: () =>  DashboardScreen(),
      binding: DashboardBinding(),
    ),


    GetPage(
      name: AppRoutes.categories,
      page: () => CategoriesPage(),
      binding: CategoryBinding(),
    ),

    GetPage(
      name: AppRoutes.subCategories,
      page: () => SubCategoryPage(),
      binding: CategoryBinding(),
    ),
    //
    GetPage(
      name: AppRoutes.addProduct,
      page: () => AddProductPage(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.productPreview,
      page: () => ProductPreviewPage(),
      // middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.locationPicker,
      page: () => LocationPickerPage(),
      binding: LocationBinding(),
    ),

    GetPage(
      name: AppRoutes.chats,
      page: () => const ChatListPage(),
      binding: ChatBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.myAds,
      page: () => const MyAdsPage(),
      binding: MyAdsBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.bannerManagement,
      page: () => const BannerManagementPage(),
      binding: BannerBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.bannerForm,
      page: () => const BannerFormPage(),
      binding: BannerBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: AppRoutes.search,
      page: () => const ProductSearchPage(),
    ),
    GetPage(
      name: AppRoutes.favourites,
      page: () => const FavouritePage(),
    ),

    GetPage(
      name: AppRoutes.agent,
      page: () => const BecomeAgentView(),
      binding: AgentBinding(),
    ),

    GetPage(
      name: AppRoutes.agentDashboard,
      page: () => const AgentDashboardView(),
      binding: AgentDashboardBinding(),
    ),

    GetPage(
      name: AppRoutes.agentClientRequests,
      page: () => const AgentClientRequestsView(),
      binding: AgentClientRequestsBinding(),
    ),

    GetPage(
      name: AppRoutes.agentPromotionRequests,
      page: () => const AgentPromotionRequestsView(),
      binding: AgentPromotionRequestsBinding(),
    ),

    GetPage(
      name: AppRoutes.agentCreateListing,
      page: () => const AgentCreateListingView(),
      binding: AgentCreateListingBinding(),
    ),

    GetPage(
      name: AppRoutes.agentListingShare,
      page: () => const AgentListingShareView(),
      binding: AgentListingShareBinding(),
    ),

    GetPage(
      name: AppRoutes.agentMyListings,
      page: () => const AgentMyListingsView(),
      binding: AgentMyListingsBinding(),
    ),

    GetPage(
      name: AppRoutes.agentAnalytics,
      page: () => const AgentAnalyticsView(),
      binding: AgentAnalyticsBinding(),
    ),

    GetPage(
      name: AppRoutes.agentDirectory,
      page: () => const AgentDirectoryView(),
      binding: AgentDirectoryBinding(),
    ),

    GetPage(
      name: AppRoutes.agentProfile,
      page: () => const AgentProfileView(),
      binding: AgentProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.agentHireRequest,
      page: () => const AgentHireRequestView(),
      binding: AgentHireRequestBinding(),
    ),
  ];
}
