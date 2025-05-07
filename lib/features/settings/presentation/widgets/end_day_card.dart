import 'package:flutter/material.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../domain/entities/end_day_report.dart';
import '../../domain/entities/report_summary.dart';

class EndDayCard extends StatelessWidget {
  final List<EndDayReport> reports;
  final List<ReportSummary> summaries;

  const EndDayCard({
    required this.reports,
    required this.summaries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(
          horizontal: context.AppResponsiveValue(
            20,
            mobile: 20,
            tablet: 20,
            desktop: 20,
          ),
          vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text("END OF DAY REPORT",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                if (reports.isNotEmpty) ...[
                  Text(
                    'Z ${reports[0].casher}', // Safely access reports[0]
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${DateTime.now()}',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Restaurant Name',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Branch',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                              width: MediaQuery.of(context).size.width * .9,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: reports.length,
                                  // scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .9,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 3.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          reports[index].casher,
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('اسم الكاشير',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          reports[index].zCashNo.toString(),
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('رقم النقطة',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          reports[index].zStartDate
                                                              .toString()
                                                              .substring(
                                                              0, 16),
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('وقت البدء',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        reports[index].zEndDate.toString().substring(0, 16),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text('وقت الانتهاء',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: buildPayments(reports[index].zPayments), // Call the buildPayments function
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(

                                                          reports[index].zReturn.toString() ,
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text('مردود المبيعات',
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            reports[index].zSales
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        VerticalDivider(),
                                                        Text('المجموع',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text((reports[index].zSales  - reports[index].zReturn).toString(),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                        VerticalDivider(),
                                                        Text(
                                                            ' المجموع النهائي',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }))
                     ,
                  ),
                ] else
                  Text("No reports available", style: TextStyle(color: Colors.red)),
                // Rest of your widget...
              ],
            ),
          ),
          // Summary and other parts...
        ],
      ),
    );
  }
  List<Widget> buildPayments(List<Zpayment> zpayment) {
    List<Widget> paymentWidgets = [];

    // Iterate over each payment summary
    zpayment.forEach((payment) {
      paymentWidgets.add(Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Row for payment amount and description
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    payment.payments.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    payment.typeArDesc, // Arabic description
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            // Row for invoice count
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    payment.invoicesCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ":عدد الفواتير", // "Number of invoices"
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
    });

    return paymentWidgets;
  }
}
