class ApiEndpoints {
  // Authentication
  static const login = 'auth/login';
  static const register = 'auth/register';

  // Users
  static const getUsers = 'users';
  static const getUserById = 'users/';
  static const updateUser = 'users/update';
  static const deleteUser = 'users/delete/';

  //Order
  static const getOrders = 'order';
  static const createOrderApi = 'order/create';

  //Cart
  static const addtoCart = '/cart/add/';
  static const getCartApi = 'cart/';
  static const clearCartApi = 'cart/clear/';
  static const removeItemCart = 'cart/remove/';

  //Customer
  static const getCustomerDetails = '/customers/';
  static const createCustomerApi = '/customers/';

  //Payment
  static const paymentPoast = '/payment';
}
