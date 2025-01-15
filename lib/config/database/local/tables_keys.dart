class TablesKeys {
  // Table names
  static const productsTable = 'productsTable';
  static const categoryTable = 'categoryTable';
  static const flavorTable = 'flavorTable';
  static const productQuestionsTable = 'productQuestionsTable';
  static const pendingOrdersTable = 'pendingOrdersTable';
  static const paymentTable = 'paymentTable';
  static const invoiceHeaderTable = 'invoiceHeaderTable';
  static const invoiceDetailsTable = 'invoiceDetailsTable';
  static const invoicesPaymentsTable = 'invoicesPaymentsTable';
  static const cartItemTable = 'cartItemTable'; // New table for CartItem
  static const cartItemFlavorTable =
      'cartItemFlavorTable'; // Junction table for CartItem and Flavor
  static const cartItemQuestionTable =
      'cartItemQuestionTable'; // Junction table for CartItem and Product (questions)
  static const cartItemOfferTable =
      'cartItemOfferTable'; // Junction table for CartItem and Offer
  static const offersTable = 'offerTable'; // New table for Offer

  // Column names for productsTable
  static const String barcode = "Barcode";
  static const String proArName = "Pro_AR_Name";
  static const String proEnName = "Pro_EN_Name";
  static const String proId = "ProID";
  static const String catId = "CatID";
  static const String categoryAr = "CategoryAr";
  static const String categoryEn = "CategoryEn";
  static const String father = "Father";
  static const String price = "Price";
  static const String price2 = "Price2";
  static const String price3 = "Price3";
  static const String price4 = "Price4";
  static const String taxable = "Taxable";
  static const String taxPercentage = "TaxPercentage";
  static const String discountable = "Discountable";
  static const String icon = "ImgPath";
  static const String backColor = "BackColor";
  static const String question1 = "Question1";
  static const String question2 = "Question2";
  static const String question3 = "Question3";
  static const String question4 = "Question4";
  static const String question5 = "Question5";
  static const String foreColor = "ForeColor";
  static const String printer = "Printer";
  static const String printer2 = "Printer2";
  static const String printer3 = "Printer3";
  static const String printer4 = "Printer4";
  static const String tag = "Tag";
  static const String standardItem = "StandardItem";
  static const String discount = "Discount";
  static const String isActive = "IsActive";
  static const String discountP = "DiscountP";
  static const String unitId = "UnitID";
  static const String addAsNote = "addAsNote";
  static const String isMaximumQty = "IsMaximumQty";
  static const String question1Qty = "Question1Qty";
  static const String question2Qty = "Question2Qty";
  static const String question3Qty = "Question3Qty";
  static const String question4Qty = "Question4Qty";
  static const String question5Qty = "Question5Qty";

  // Column names for categoryTable
  static const String catArName = "Cat_AR_Name";
  static const String catEnName = "Cat_EN_Name";
  static const String saleable = "Saleable";

  // Column names for flavorTable
  static const String flavorNo = "FlavorNo";
  static const String flavorAR = "FlavorAr";
  static const String flavorEN = "FlavorEn";
  static const String priceFlavor = "Price";
  static const String warehouseFlavor = "Warehouse";
  static const String categoryFlavor = "Category";
  static const String isActiveFlavor = "isActive";
  static const String rawMaterial = "RawMaterial";
  static const String compositeMaterial = "CompositeMaterial";
  static const String compo = "Compo";

  // Column names for productQuestions
  static const String productId = "ProductId";
  static const String questionElements1 = "QuestionElements1";
  static const String productQuestionId = "ProductQuestionId";
  static const String productPrice = "ProductPrice";
  static const String isRequired = "IsRequired";
  static const String questionAr = "QuestionAr";

  // Column names for paymentTable
  static const String ptype = "ptype";
  static const String paymentArDesc = "paymentArDesc";
  static const String paymentEnDesc = "paymentEnDesc";
  static const String isActivePayment = "isActive";

  // Column names for invoiceHeaderTable
  static const String invoiceNo = "InvoiceNo";
  static const String invoiceCashNo = "InvoiceCashNo";
  static const String isPrinted = "IsPrinted";
  static const String invoiceSubTotal = "InvoiceSubTotal";
  static const String invoiceDiscountTotal = "InvoiceDiscountTotal";
  static const String invoiceServiceTotal = "InvoiceServiceTotal";
  static const String invoiceTaxTotal = "InvoiceTaxTotal";
  static const String invoiceGrandTotal = "InvoiceGrandTotal";
  static const String customer = "Customer";
  static const String realTime = "RealTime";
  static const String tableNo = "TableNo";
  static const String empTaker = "EmpTaker";
  static const String qrcode = "Qrcode";
  static const String queue = "Queue";
  static const String cashPayment = "CashPayment";
  static const String warehouse = "Warehouse";
  static const String salesDate = "SalesDate";
  static const String deliveryCompany = "DeliveryCompany";
  static const String stationId = "StationId";

  // Column names for invoiceDetailsTable
  static const String id = "id";
  static const String item = "Item";
  static const String qty = "Qty";
  static const String priceDetails = "Price";
  static const String subTotal = "SubTotal";
  static const String discountV = "DiscountV";
  static const String taxP = "TaxP";
  static const String taxV = "TaxV";
  static const String grandTotal = "GrandTotal";
  static const String flavors = "Flavors";
  static const String offerNo = "offerNo";
  static const String warehouseDetails = "Warehouse";
  static const String salesDateDetails = "SalesDate";
  static const String lineId = "LineId";
  static const String unitID = "UnitID";

  // Column names for invoicesPaymentsTable
  static const String payType = "payType";
  static const String payment = "payment";
  static const String creditExpireDate = "creditExpireDate";
  static const String warehousePayments = "warehouse";

  static const String lastUpdateTable = 'lastUpdateTable';
  static const String tableNameColumn = 'tableName';
  static const String lastUpdateColumn = 'lastUpdate';

  // Column names for CartItem table
  static const String cartItemId = "id";
  static const String cartItemProductId = "productId";
  static const String cartItemIsOffer = "isOffer";
  static const String cartItemQuantity = "quantity";
  static const String cartItemNote = "note";
  static const String cartItemExtraItemId = "extraItemId";
  static const String cartItemOriginalPrice = "originalPrice";

  // Column names for Offer table
  static const String offerId = "OfferId";
  static const String offerProductId = "productId";
  static const String productNameAr = "ProductNameAr";
  static const String productNameEn = "ProductNameEn";
  static const String fromDate = "FromDate";
  static const String toDate = "ToDate";
  static const String priceOffer = "PriceOffer";
  static const String qtyOffer = "QtyOffer";
  static const String extraOffer = "ExtraOffer";
  static const String offerPrice = "price";
  static const String offerQty = "qty";
  static const String extraProduct = "ExtraProduct";
  static const String offerIsActive = "isActive";
  static const String extraProductAr = "ExtraProductAr";
  static const String extraProductEn = "ExtraProductEn";
  static const String offerTypeAr = "OfferTypeAr";
  static const String offerTypeEn = "OfferTypeEn";
  static const String offerValueAr = "offerValueAr";
  static const String offerValueEn = "offerValueEn";

  static const String orderId = "orderId";
  static const String ordersTable = "orderTable";
  static const String orderDate = "orderDate";
  static const String orderStatus = "orderStatus";
}
