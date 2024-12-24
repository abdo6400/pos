class EndPoints {
  // Base URL
  static const String baseUrl = 'https://api.futec-soft.com/';
  static const String prefixToken = 'Bearer ';
  static const String refresh = '';
  static const String response = "Response";
  // Auth Endpoints
  static const String login = 'Profile/v1.0/AppLogin';

  // Sales Endpoints
  static const String getSalesByWarehouse =
      'RestaurantSalesDay/v1.0/AppGetByWarehouse';
  static const String getSalesByUser = 'RestaurantSales/v1.0/AppGetByUser';
  static const String openPointByParameters =
      'RestaurantSales/v1.0/OpenPointByParameters';
  static const String openLastDay = 'RestaurantSalesDay/v1.0/OpenLastDay';
  static const String getSalesByDate = 'RestaurantSales/v1.0/AppGetByDate';
  static const String closePoint = 'RestaurantSales/v1.0/ClosePoint';

  // Item Endpoints
  static const String getAllItems = 'Item/v1.0/AppGetAll?Warehouse';
  static const String getAllCategories = 'Category/v1.0/AppGetAll';
  static const String getAllFlavors = 'Flavors/v1.0/AppGetAll';
  static const String getAllDiscounts = 'Discount/v1.0/AppGetAll';
  static const String getAllOffers = 'Offers/v1.0/AppGetAll';
  static const String getAllPaymentTypes = 'PaymentsType/v1.0/AppGetAll';
  static const String getAllDeliveryCompanies = 'DeliveyCompany/v1.0/AppGetAll';

  // Invoice Endpoints
  static const String getInvoicesByIntervalDateAndUser =
      'RestaurantInvoices/v1.0/GetByIntervalDateAndUser';
  static const String insertInvoice = 'RestaurantInvoices/v1.0/Insert';
  static const String getLastInvoiceNo =
      'RestaurantInvoices/v1.0/AppGetLastInvoiceNo';

  // Return Endpoints
  static const String getReturnByDate = 'Return/v1.0/AppGetByDate';
  static const String insertReturn = 'Return/v1.0/ReturnInsert';
  static const String getReturnById = 'Return/v1.0/GetById';
  static const String getReturnByInvoice =
      'RestaurantInvoices/v1.0/AppGetByDiff?InvoiceN';

  // Settings Endpoints
  static const String getSettings = 'Profile/v1.0/GetSettings';

  // Miscellaneous
  static const String getAllUnits = 'Units/v1.0/GetAll';
  static const String getItemQuestions = 'Item/v1.0/AppGetAllQuestion';
  static const String getSalesSummary = 'RestaurantSales/v1.0/GetSalesSummary';
  static const String getSalesByCashNo =
      'RestaurantSales/v1.0/AppGetPaymentsByCashNo';
}
