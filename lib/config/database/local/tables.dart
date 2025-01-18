import 'package:sqflite/sqflite.dart';
import 'tables_keys.dart';

class Tables {
  static Future<void> createTables(Database db) async {
    await db.execute(createProductsTable);
    await db.execute(createCategoryTable);
    await db.execute(createFlavorTable);
    await db.execute(createProductQuestions);
    await db.execute(createCartItemTable);
    await db.execute(createCartItemFlavorTable);
    await db.execute(createCartItemQuestionTable);
    await db.execute(createCartItemOfferTable);
    await db.execute(createOfferTable);
    await db.execute(createLastUpdateTable);
    await db.execute(createOrderTable);
    await db.execute(createPaymentTypeTable);
    await db.execute(createInvoicesTable);
    await db.execute(createInvoiceDtlTable);
    await db.execute(createInvoicePaymentTable);
  }

  static String get createLastUpdateTable => '''
  CREATE TABLE ${TablesKeys.lastUpdateTable}(
    ${TablesKeys.tableNameColumn} TEXT PRIMARY KEY,
    ${TablesKeys.lastUpdateColumn} INTEGER
  )
''';

  static String get createProductsTable => '''
  CREATE TABLE ${TablesKeys.productsTable}(
    ${TablesKeys.proId} TEXT,   
    ${TablesKeys.barcode} TEXT,
    ${TablesKeys.proArName} TEXT,
    ${TablesKeys.proEnName} TEXT, 
    ${TablesKeys.catId} TEXT,
    ${TablesKeys.categoryAr} TEXT,   
    ${TablesKeys.categoryEn} TEXT, 
    ${TablesKeys.father} TEXT, 
    ${TablesKeys.price} REAL,
    ${TablesKeys.price2} REAL,
    ${TablesKeys.price3} REAL,
    ${TablesKeys.price4} REAL,
    ${TablesKeys.taxable} TEXT,
    ${TablesKeys.taxPercentage} REAL,   
    ${TablesKeys.discountable} TEXT, 
    ${TablesKeys.icon} TEXT,
    ${TablesKeys.backColor} TEXT, 
    ${TablesKeys.foreColor} TEXT,   
    ${TablesKeys.tag} TEXT, 
    ${TablesKeys.printer} TEXT, 
    ${TablesKeys.printer2} TEXT,
    ${TablesKeys.question1} TEXT,         
    ${TablesKeys.question2} TEXT,         
    ${TablesKeys.question3} TEXT,         
    ${TablesKeys.question4} TEXT,         
    ${TablesKeys.question5} TEXT,         
    ${TablesKeys.standardItem} TEXT,  
    ${TablesKeys.isActive} TEXT,  
    ${TablesKeys.rawMaterial} TEXT,     
    ${TablesKeys.compositeMaterial} TEXT,
    ${TablesKeys.compo} TEXT,
    ${TablesKeys.isMaximumQty} TEXT,
    ${TablesKeys.question1Qty} INTEGER,
    ${TablesKeys.question2Qty} INTEGER,
    ${TablesKeys.question3Qty} INTEGER,
    ${TablesKeys.question4Qty} INTEGER,
    ${TablesKeys.question5Qty} INTEGER     
  )
''';

  static String get createCategoryTable => '''
    CREATE TABLE ${TablesKeys.categoryTable}(
      ${TablesKeys.catId} TEXT,
      ${TablesKeys.catEnName} TEXT,
      ${TablesKeys.catArName} TEXT,
      ${TablesKeys.taxPercentage} TEXT,
      ${TablesKeys.icon} TEXT,
      ${TablesKeys.backColor} TEXT,
      ${TablesKeys.foreColor} TEXT,
      ${TablesKeys.price} TEXT,
      ${TablesKeys.printer} TEXT,
      ${TablesKeys.printer2} TEXT,
      ${TablesKeys.tag} TEXT,
      ${TablesKeys.question1} TEXT,
      ${TablesKeys.question2} TEXT,
      ${TablesKeys.question3} TEXT,
      ${TablesKeys.question4} TEXT,
      ${TablesKeys.question5} TEXT,
      ${TablesKeys.saleable} TEXT,
      ${TablesKeys.standardItem} TEXT,
      ${TablesKeys.discountable} TEXT
    )
  ''';

  static String get createFlavorTable => '''
    CREATE TABLE ${TablesKeys.flavorTable}(
      ${TablesKeys.flavorNo} INTEGER,
      ${TablesKeys.flavorAR} TEXT,
      ${TablesKeys.flavorEN} TEXT,
      ${TablesKeys.priceFlavor} REAL, 
      ${TablesKeys.warehouseFlavor} TEXT,
      ${TablesKeys.categoryFlavor} TEXT,
      ${TablesKeys.isActiveFlavor} TEXT
    )
  ''';

  static String get createProductQuestions => '''
    CREATE TABLE ${TablesKeys.productQuestionsTable}(
      ${TablesKeys.productId} TEXT,
      ${TablesKeys.questionElements1} TEXT,
      ${TablesKeys.productQuestionId} INTEGER,
      ${TablesKeys.productPrice} REAL,
      ${TablesKeys.isRequired} TEXT,
      ${TablesKeys.questionAr} TEXT
    )
  ''';

  static String get createOrderTable => '''
  CREATE TABLE ${TablesKeys.ordersTable}(
    ${TablesKeys.orderId} TEXT PRIMARY KEY,
    ${TablesKeys.orderDate} TEXT NOT NULL,
    ${TablesKeys.orderStatus} TEXT
  )
''';

  static String get createCartItemTable => '''
  CREATE TABLE ${TablesKeys.cartItemTable}(
    ${TablesKeys.cartItemId} TEXT PRIMARY KEY,
    ${TablesKeys.cartItemProductId} TEXT NOT NULL,
    ${TablesKeys.cartItemIsOffer} TEXT NOT NULL,
    ${TablesKeys.cartItemQuantity} INTEGER NOT NULL,
    ${TablesKeys.cartItemNote} TEXT DEFAULT '',
    ${TablesKeys.cartItemExtraItemId} TEXT,
    ${TablesKeys.cartItemOriginalPrice} REAL NOT NULL,
    ${TablesKeys.orderId} TEXT,
    FOREIGN KEY (${TablesKeys.cartItemProductId}) REFERENCES ${TablesKeys.productsTable}(${TablesKeys.proId}),
    FOREIGN KEY (${TablesKeys.orderId}) REFERENCES ${TablesKeys.ordersTable}(${TablesKeys.orderId}) ON DELETE CASCADE
  )
''';

  static String get createCartItemFlavorTable => '''
  CREATE TABLE ${TablesKeys.cartItemFlavorTable}(
    ${TablesKeys.cartItemId} TEXT NOT NULL,
    ${TablesKeys.flavorNo} INTEGER NOT NULL,
    PRIMARY KEY (${TablesKeys.cartItemId}, ${TablesKeys.flavorNo}),
    FOREIGN KEY (${TablesKeys.cartItemId}) REFERENCES ${TablesKeys.cartItemTable}(${TablesKeys.cartItemId}) ON DELETE CASCADE,
    FOREIGN KEY (${TablesKeys.flavorNo}) REFERENCES ${TablesKeys.flavorTable}(${TablesKeys.flavorNo})
  )
''';

  static String get createCartItemQuestionTable => '''
  CREATE TABLE ${TablesKeys.cartItemQuestionTable}(
    ${TablesKeys.cartItemId} TEXT NOT NULL,
    ${TablesKeys.productId} TEXT NOT NULL,
    PRIMARY KEY (${TablesKeys.cartItemId}, ${TablesKeys.productId}),
    FOREIGN KEY (${TablesKeys.cartItemId}) REFERENCES ${TablesKeys.cartItemTable}(${TablesKeys.cartItemId}) ON DELETE CASCADE,
    FOREIGN KEY (${TablesKeys.productId}) REFERENCES ${TablesKeys.productQuestionsTable}(${TablesKeys.productId})
  )
''';

  static String get createCartItemOfferTable => '''
  CREATE TABLE ${TablesKeys.cartItemOfferTable}(
    ${TablesKeys.cartItemId} TEXT NOT NULL,
    ${TablesKeys.offerId} INTEGER NOT NULL,
    PRIMARY KEY (${TablesKeys.cartItemId}, ${TablesKeys.offerId}),
    FOREIGN KEY (${TablesKeys.cartItemId}) REFERENCES ${TablesKeys.cartItemTable}(${TablesKeys.cartItemId}) ON DELETE CASCADE,
    FOREIGN KEY (${TablesKeys.offerId}) REFERENCES ${TablesKeys.offersTable}(${TablesKeys.offerId})
  )
''';

  static String get createOfferTable => '''
    CREATE TABLE ${TablesKeys.offersTable}(
      ${TablesKeys.offerId} INTEGER PRIMARY KEY,
      ${TablesKeys.offerProductId} TEXT NOT NULL,
      ${TablesKeys.productNameAr} TEXT,
      ${TablesKeys.productNameEn} TEXT,
      ${TablesKeys.fromDate} TEXT NOT NULL,
      ${TablesKeys.toDate} TEXT NOT NULL,
      ${TablesKeys.priceOffer} TEXT,
      ${TablesKeys.qtyOffer} TEXT,
      ${TablesKeys.extraOffer} TEXT,
      ${TablesKeys.offerPrice} REAL,
      ${TablesKeys.offerQty} INTEGER,
      ${TablesKeys.extraProduct} TEXT,
      ${TablesKeys.offerIsActive} TEXT,
      ${TablesKeys.extraProductAr} TEXT,
      ${TablesKeys.extraProductEn} TEXT,
      ${TablesKeys.offerTypeAr} TEXT,
      ${TablesKeys.offerTypeEn} TEXT,
      ${TablesKeys.offerValueAr} TEXT,
      ${TablesKeys.offerValueEn} TEXT,
      FOREIGN KEY (${TablesKeys.offerProductId}) REFERENCES ${TablesKeys.productsTable}(${TablesKeys.proId})
    )
  ''';

  static String get createPaymentTypeTable => '''
    CREATE TABLE ${TablesKeys.paymentTypesTable}(
      ${TablesKeys.ptype} INTEGER NOT NULL,
      ${TablesKeys.paymentArDesc} TEXT NOT NULL,
      ${TablesKeys.paymentEnDesc} TEXT NOT NULL,
      ${TablesKeys.isActive} TEXT NOT NULL,
      ${TablesKeys.cashMoney} TEXT NOT NULL,
      ${TablesKeys.commissions} REAL NOT NULL,
      ${TablesKeys.coupon} TEXT,
      ${TablesKeys.isCredit} TEXT NOT NULL,
      ${TablesKeys.companyId} INTEGER NOT NULL
    )
  ''';

  static String get createInvoicesTable => '''
    CREATE TABLE ${TablesKeys.paymentsTable}(
      ${TablesKeys.invoiceNo} TEXT PRIMARY KEY,
      ${TablesKeys.invoiceCashNo} INTEGER NOT NULL,
      ${TablesKeys.invoiceSubTotal} INTEGER NOT NULL,
      ${TablesKeys.invoiceDiscountTotal} INTEGER NOT NULL,
      ${TablesKeys.invoiceServiceTotal} INTEGER NOT NULL,
      ${TablesKeys.invoiceTaxTotal} INTEGER NOT NULL,
      ${TablesKeys.invoiceGrandTotal} INTEGER NOT NULL,
      ${TablesKeys.isPrinted} TEXT NOT NULL,
      ${TablesKeys.customer} INTEGER NOT NULL,
      ${TablesKeys.realTime} TEXT NOT NULL,
      ${TablesKeys.tableNo} INTEGER NOT NULL,
      ${TablesKeys.empTaker} INTEGER NOT NULL,
      ${TablesKeys.takerName} TEXT NOT NULL,
      ${TablesKeys.queue} INTEGER NOT NULL,
      ${TablesKeys.cashPayment} INTEGER NOT NULL,
      ${TablesKeys.warehouse} INTEGER NOT NULL,
      ${TablesKeys.salesDate} TEXT NOT NULL,
      ${TablesKeys.deliveryCompany} INTEGER NOT NULL,
      ${TablesKeys.encryptionSeal} TEXT NOT NULL,
      ${TablesKeys.guid} TEXT NOT NULL,
      ${TablesKeys.qrcode} TEXT NOT NULL,
      ${TablesKeys.stationId} TEXT NOT NULL
    )
  ''';

  static String get createInvoiceDtlTable => '''
    CREATE TABLE ${TablesKeys.invoiceDtlTable}(
      ${TablesKeys.invoiceNo} TEXT NOT NULL,
      ${TablesKeys.item} TEXT NOT NULL,
      ${TablesKeys.qty} INTEGER NOT NULL,
      ${TablesKeys.price} INTEGER NOT NULL,
      ${TablesKeys.subtotal} INTEGER NOT NULL,
      ${TablesKeys.discountV} INTEGER NOT NULL,
      ${TablesKeys.discountP} INTEGER NOT NULL,
      ${TablesKeys.taxP} INTEGER NOT NULL,
      ${TablesKeys.taxV} INTEGER NOT NULL,
      ${TablesKeys.grandTotal} INTEGER NOT NULL,
      ${TablesKeys.taker} INTEGER NOT NULL,
      ${TablesKeys.flavors} TEXT NOT NULL,
      ${TablesKeys.warehouse} INTEGER NOT NULL,
      ${TablesKeys.salesDate} TEXT NOT NULL,
      ${TablesKeys.offerNo} INTEGER NOT NULL,
      ${TablesKeys.lineId} INTEGER NOT NULL,
      FOREIGN KEY (${TablesKeys.invoiceNo}) REFERENCES ${TablesKeys.paymentsTable}(${TablesKeys.invoiceNo}) ON DELETE CASCADE
    )
  ''';

  static String get createInvoicePaymentTable => '''
    CREATE TABLE ${TablesKeys.invoicePaymentTable}(
      ${TablesKeys.invoiceId} TEXT NOT NULL,
      ${TablesKeys.payType} INTEGER NOT NULL,
      ${TablesKeys.payment} REAL NOT NULL,
      ${TablesKeys.creditExpireDate} TEXT NOT NULL,
      ${TablesKeys.warehouse} TEXT NOT NULL,
      FOREIGN KEY (${TablesKeys.invoiceId}) REFERENCES ${TablesKeys.paymentsTable}(${TablesKeys.invoiceNo}) ON DELETE CASCADE
    )
  ''';
}
