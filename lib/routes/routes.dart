class KRoutes {
  static const home = '/';
  static const store = '/store';
  static const favourites = '/favourites';
  static const settings = '/settings';

  static const subCategories = '/sub-categories';
  static const search = '/search';
  static const productReviews = '/product-reviews';
  static const productDetail = '/product-detail';
  static const order = '/order';
  static const checkout = '/checkout';
  static const cart = '/cart';
  static const brand = '/brand';
  static const allProducts = '/all-products';

// SECURITY AND PERSONALIZATION
  static const userProfile = '/user-profile';
  static const userAddress = '/user-address';
  static const signup = '/signup';
  static const signupSuccess = '/signup-success';
  static const verifyEmail = '/verify-email';
  static const login = '/login/';
  static const resetPassword = '/reset-password/';
  static const forgetPassword = '/forget-password/';
  static const onBoardinig = '/onboarding';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProducts = '/createProducts';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const customers = '/customers';
  static const createCustomers = '/createCustomers';
  static const customerDetails = '/customerDetails';

  // LIST OF ROUTES
  static List sidebarMenuItems = [
    home,
    store,
    favourites,
    settings,
    subCategories,
    search,
    productReviews,
    productDetail,
    order,
    checkout,
    cart,
    brand,
    allProducts,
    userProfile,
    userAddress,
    signup,
    signupSuccess,
    verifyEmail,
    login,
    resetPassword,
    forgetPassword,
    media,
    banners,
    createBanner,
    editBanner,
    products,
    createProducts,
    editProduct,
    categories,
    createCategory,
    editCategory,
    brands,
    createBrand,
    editBrand,
    customers,
    createCustomers,
    customerDetails,
    // Add more routes here as needed
  ];
}
