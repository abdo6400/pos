import 'package:sqflite/sqflite.dart';

class Tables {
  static const productsTable = 'productsTable';
  static const categoryTable = 'categoryTable';
  static const flavorTable = 'flavorTable';
  static const paymentTable = 'paymentTable';
  static const invoiceHeaderTable = 'invoiceHeaderTable';
  static const invoiceDetailsTable = 'invoiceDetailsTable';
  static const invoicesPaymentsTable = 'invoicesPaymentsTable';

  static Future<void> createTables(Database db) async {
    await db.execute(Tables.createProductsTable);
    await db.execute(Tables.createCategoryTable);
    await db.execute(Tables.createFlavorTable);
    await db.execute(Tables.createPaymentTable);
    await db.execute(Tables.createInvoiceHeaderTable);
    await db.execute(Tables.createInvoiceDetailsObjTable);
    await db.execute(Tables.createInvoicesPaymentsTable);
  }

  static String get createProductsTable => '''
    CREATE TABLE $productsTable(
      Barcode TEXT,
      Pro_AR_Name TEXT,
      Pro_EN_Name TEXT, 
      ProID TEXT,   
      CatID TEXT,
      CategoryAr TEXT,   
      CategoryEn TEXT, 
      Father TEXT, 
      Price REAL,
      Price2 REAL,
      Price3 REAL,
      Price4 REAL,
      Taxable INTEGER,
      TaxPercentage REAL,   
      Discountable INTEGER, 
      Icon TEXT,
      BackColor TEXT,
      Question1 INTEGER,
      Question2 INTEGER,
      Question3 INTEGER,
      Question4 INTEGER,
      Question5 INTEGER,
      ForeColor TEXT,   
      Printer TEXT, 
      Printer2 TEXT,
      Printer3 TEXT,
      Printer4 TEXT,   
      Tag TEXT, 
      StandardItem INTEGER,
      Discount REAL,
      IsActive INTEGER,  
      DiscountP REAL ,
      UnitID INTEGER,
      addAsNote INTEGER,
      IsMaximumQty INTEGER,
      Question1Qty INTEGER,
      Question2Qty INTEGER,
      Question3Qty INTEGER,
      Question4Qty INTEGER,
      Question5Qty INTEGER
    )
  ''';

  static String get createCategoryTable => '''
    CREATE TABLE $categoryTable(
      catID INTEGER,
      Cat_EN_Name TEXT,
      Cat_AR_Name TEXT,
      taxPercentage REAL,
      icon TEXT,
      backColor TEXT,
      foreColor TEXT,
      price REAL,
      printer TEXT,
      printer2 TEXT,
      printer3 TEXT,
      printer4 TEXT,
      tag TEXT,
      question1 INTEGER,
      question2 INTEGER,
      question3 INTEGER,
      question4 INTEGER,
      question5 INTEGER,
      saleable INTEGER,
      standardItem INTEGER,
      discountable INTEGER,
      subCatId INTEGER,
      isActive INTEGER
    )
  ''';

  static String get createFlavorTable => '''
    CREATE TABLE $flavorTable(
      FlavorNo INTEGER,
      FlavorAR TEXT,
      FlavorEN TEXT,
      Price REAL, 
      Warehouse TEXT,
      Category TEXT,
      isActive INTEGER
    )
  ''';

  static String get createPaymentTable => '''
    CREATE TABLE $paymentTable(
      ptype INTEGER,
      paymentArDesc TEXT,
      paymentEnDesc TEXT,  
      isActive INTEGER
    )
  ''';

  static String get createInvoiceHeaderTable => '''
    CREATE TABLE $invoiceHeaderTable(
      InvoiceNo REAL,
      InvoiceCashNo REAL,
      IsPrinted INTEGER,
      InvoiceSubTotal REAL, 
      InvoiceDiscountTotal REAL,   
      InvoiceServiceTotal REAL,
      InvoiceTaxTotal REAL,            
      InvoiceGrandTotal REAL, 
      Customer INTEGER, 
      RealTime TEXT,
      TableNo INTEGER,
      EmpTaker INTEGER,  
      Qrcode TEXT,
      Queue INTEGER, 
      CashPayment REAL,
      Warehouse INTEGER,
      SalesDate TEXT,
      DeliveryCompany INTEGER,
      StationId TEXT
    )
  ''';

  static String get createInvoiceDetailsObjTable => '''
    CREATE TABLE $invoiceDetailsTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      InvoiceNo REAL,
      Item TEXT,
      Qty REAL, 
      Price REAL,   
      SubTotal REAL,
      DiscountV REAL,   
      DiscountP REAL, 
      TaxP REAL, 
      TaxV REAL,
      GrandTotal REAL,
      Flavors TEXT,
      offerNo INTEGER,   
      Warehouse INTEGER,
      SalesDate TEXT,
      LineId INTEGER,
      UnitID REAL
    )
  ''';

  static String get createInvoicesPaymentsTable => '''
    CREATE TABLE $invoicesPaymentsTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      InvoiceNo REAL,
      payType INTEGER,
      payment REAL, 
      creditExpireDate TEXT,   
      warehouse TEXT
    )
  ''';
}
