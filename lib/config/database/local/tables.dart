import 'package:sqflite/sqflite.dart';

class Tables {
  // Table names
  static const productsTable = 'productsTable';
  static const categoryTable = 'categoryTable';
  static const flavorTable = 'flavorTable';
  static const productQuestionsTable = 'productQuestionsTable';
  static const paymentTable = 'paymentTable';
  static const invoiceHeaderTable = 'invoiceHeaderTable';
  static const invoiceDetailsTable = 'invoiceDetailsTable';
  static const invoicesPaymentsTable = 'invoicesPaymentsTable';

  // Column names for productsTable
  static const String barcode = 'Barcode';
  static const String proArName = 'Pro_AR_Name';
  static const String proEnName = 'Pro_EN_Name';
  static const String proId = 'ProID';
  static const String catId = 'CatID';
  static const String categoryAr = 'CategoryAr';
  static const String categoryEn = 'CategoryEn';
  static const String father = 'Father';
  static const String price = 'Price';
  static const String price2 = 'Price2';
  static const String price3 = 'Price3';
  static const String price4 = 'Price4';
  static const String taxable = 'Taxable';
  static const String taxPercentage = 'TaxPercentage';
  static const String discountable = 'Discountable';
  static const String icon = 'ImgPath';
  static const String backColor = 'BackColor';
  static const String question1 = 'Question1';
  static const String question2 = 'Question2';
  static const String question3 = 'Question3';
  static const String question4 = 'Question4';
  static const String question5 = 'Question5';
  static const String foreColor = 'ForeColor';
  static const String printer = 'Printer';
  static const String printer2 = 'Printer2';
  static const String printer3 = 'Printer3';
  static const String printer4 = 'Printer4';
  static const String tag = 'Tag';
  static const String standardItem = 'StandardItem';
  static const String discount = 'Discount';
  static const String isActive = 'IsActive';
  static const String discountP = 'DiscountP';
  static const String unitId = 'UnitID';
  static const String addAsNote = 'addAsNote';
  static const String isMaximumQty = 'IsMaximumQty';
  static const String question1Qty = 'Question1Qty';
  static const String question2Qty = 'Question2Qty';
  static const String question3Qty = 'Question3Qty';
  static const String question4Qty = 'Question4Qty';
  static const String question5Qty = 'Question5Qty';

  // Column names for categoryTable
  static const String catArName = "Cat_AR_Name";
  static const String catEnName = "Cat_EN_Name";
  static const String saleable = "Saleable";

  // Column names for flavorTable
  static const String flavorNo = 'FlavorNo';
  static const String flavorAR = 'FlavorAR';
  static const String flavorEN = 'FlavorEN';
  static const String priceFlavor = 'Price';
  static const String warehouseFlavor = 'Warehouse';
  static const String categoryFlavor = 'Category';
  static const String isActiveFlavor = 'isActive';
  static const String rawMaterial = 'RawMaterial';
  static const String compositeMaterial = 'CompositeMaterial';
  static const String compo = 'Compo';
  // Column names for productQuestions
  static const String productId = 'ProductId';
  static const String questionElements1 = 'QuestionElements1';
  static const String productQuestionId = 'ProductQuestionId';
  static const String productPrice = 'ProductPrice';
  static const String isRequired = 'IsRequired';
  static const String questionAr = 'QuestionAr';

  // Column names for paymentTable
  static const String ptype = 'ptype';
  static const String paymentArDesc = 'paymentArDesc';
  static const String paymentEnDesc = 'paymentEnDesc';
  static const String isActivePayment = 'isActive';

  // Column names for invoiceHeaderTable
  static const String invoiceNo = 'InvoiceNo';
  static const String invoiceCashNo = 'InvoiceCashNo';
  static const String isPrinted = 'IsPrinted';
  static const String invoiceSubTotal = 'InvoiceSubTotal';
  static const String invoiceDiscountTotal = 'InvoiceDiscountTotal';
  static const String invoiceServiceTotal = 'InvoiceServiceTotal';
  static const String invoiceTaxTotal = 'InvoiceTaxTotal';
  static const String invoiceGrandTotal = 'InvoiceGrandTotal';
  static const String customer = 'Customer';
  static const String realTime = 'RealTime';
  static const String tableNo = 'TableNo';
  static const String empTaker = 'EmpTaker';
  static const String qrcode = 'Qrcode';
  static const String queue = 'Queue';
  static const String cashPayment = 'CashPayment';
  static const String warehouse = 'Warehouse';
  static const String salesDate = 'SalesDate';
  static const String deliveryCompany = 'DeliveryCompany';
  static const String stationId = 'StationId';

  // Column names for invoiceDetailsTable
  static const String id = 'id';
  static const String item = 'Item';
  static const String qty = 'Qty';
  static const String priceDetails = 'Price';
  static const String subTotal = 'SubTotal';
  static const String discountV = 'DiscountV';
  static const String taxP = 'TaxP';
  static const String taxV = 'TaxV';
  static const String grandTotal = 'GrandTotal';
  static const String flavors = 'Flavors';
  static const String offerNo = 'offerNo';
  static const String warehouseDetails = 'Warehouse';
  static const String salesDateDetails = 'SalesDate';
  static const String lineId = 'LineId';
  static const String unitID = 'UnitID';

  // Column names for invoicesPaymentsTable
  static const String payType = 'payType';
  static const String payment = 'payment';
  static const String creditExpireDate = 'creditExpireDate';
  static const String warehousePayments = 'warehouse';

  static const String lastUpdateTable = 'lastUpdateTable';
  static const String tableNameColumn = 'tableName';
  static const String lastUpdateColumn = 'lastUpdate';

  // Table creation statements
  static Future<void> createTables(Database db) async {
    await db.execute(createProductsTable);
    await db.execute(createCategoryTable);
    await db.execute(createFlavorTable);
    await db.execute(createProductQuestions);
    // await db.execute(createPaymentTable);
    // await db.execute(createInvoiceHeaderTable);
    // await db.execute(createInvoiceDetailsTable);
    // await db.execute(createInvoicesPaymentsTable);
    await db.execute(createLastUpdateTable);
  }

  static String get createLastUpdateTable => '''
  CREATE TABLE $lastUpdateTable(
    $tableNameColumn TEXT PRIMARY KEY,
    $lastUpdateColumn INTEGER
  )
''';
  static String get createProductsTable => '''
  CREATE TABLE $productsTable(
    $proId TEXT,   
    $barcode TEXT,
    $proArName TEXT,
    $proEnName TEXT, 
    $catId TEXT,
    $categoryAr TEXT,   
    $categoryEn TEXT, 
    $father TEXT, 
    $price REAL,
    $price2 REAL,
    $price3 REAL,
    $price4 REAL,
    $taxable TEXT,
    $taxPercentage REAL,   
    $discountable TEXT, 
    $icon TEXT,
    $backColor TEXT, 
    $foreColor TEXT,   
    $tag TEXT, 
    $printer TEXT, 
    $printer2 TEXT,
    $question1 TEXT,         
    $question2 TEXT,         
    $question3 TEXT,         
    $question4 TEXT,         
    $question5 TEXT,         
    $standardItem TEXT,  
    $isActive TEXT,  
    $rawMaterial TEXT,     
    $compositeMaterial TEXT,
    $compo TEXT,
    $isMaximumQty TEXT,
    $question1Qty INTEGER,
    $question2Qty INTEGER,
    $question3Qty INTEGER,
    $question4Qty INTEGER,
    $question5Qty INTEGER     
  )
''';
  static String get createCategoryTable => '''
    CREATE TABLE $categoryTable(
      $catId TEXT,
      $catEnName TEXT,
      $catArName TEXT,
      $taxPercentage TEXT,
      $icon TEXT,
      $backColor TEXT,
      $foreColor TEXT,
      $price TEXT,
      $printer TEXT,
      $printer2 TEXT,
      $tag TEXT,
      $question1 TEXT,
      $question2 TEXT,
      $question3 TEXT,
      $question4 TEXT,
      $question5 TEXT,
      $saleable TEXT,
      $standardItem TEXT,
      $discountable TEXT
    )
  ''';

  static String get createFlavorTable => '''
    CREATE TABLE $flavorTable(
      $flavorNo INTEGER,
      $flavorAR TEXT,
      $flavorEN TEXT,
      $priceFlavor REAL, 
      $warehouseFlavor TEXT,
      $categoryFlavor TEXT,
      $isActiveFlavor TEXT
    )
  ''';

  static String get createProductQuestions => '''
    CREATE TABLE $productQuestionsTable(
      $productId TEXT,
      $questionElements1 TEXT,
      $productQuestionId INTEGER,
      $productPrice REAL,
      $isRequired TEXT,
      $questionAr TEXT
    )
  ''';

  static String get createPaymentTable => '''
    CREATE TABLE $paymentTable(
      $ptype INTEGER,
      $paymentArDesc TEXT,
      $paymentEnDesc TEXT,  
      $isActivePayment INTEGER
    )
  ''';

  static String get createInvoiceHeaderTable => '''
    CREATE TABLE $invoiceHeaderTable(
      $invoiceNo REAL,
      $invoiceCashNo REAL,
      $isPrinted INTEGER,
      $invoiceSubTotal REAL, 
      $invoiceDiscountTotal REAL,   
      $invoiceServiceTotal REAL,
      $invoiceTaxTotal REAL,            
      $invoiceGrandTotal REAL, 
      $customer INTEGER, 
      $realTime TEXT,
      $tableNo INTEGER,
      $empTaker INTEGER,  
      $qrcode TEXT,
      $queue INTEGER, 
      $cashPayment REAL,
      $warehouse INTEGER,
      $salesDate TEXT,
      $deliveryCompany INTEGER,
      $stationId TEXT
    )
  ''';

  static String get createInvoiceDetailsTable => '''
    CREATE TABLE $invoiceDetailsTable(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $invoiceNo REAL,
      $item TEXT,
      $qty REAL, 
      $priceDetails REAL,   
      $subTotal REAL,
      $discountV REAL,   
      $discountP REAL, 
      $taxP REAL, 
      $taxV REAL,
      $grandTotal REAL,
      $flavors TEXT,
      $offerNo INTEGER,   
      $warehouseDetails INTEGER,
      $salesDateDetails TEXT,
      $lineId INTEGER,
      $unitID REAL
    )
  ''';

  static String get createInvoicesPaymentsTable => '''
    CREATE TABLE $invoicesPaymentsTable(
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $invoiceNo REAL,
      $payType INTEGER,
      $payment REAL, 
      $creditExpireDate TEXT,   
      $warehousePayments TEXT
    )
  ''';
}
