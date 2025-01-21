import 'package:equatable/equatable.dart';

abstract class InvoiceId extends Equatable {
  final String invoiceNo;
  final int queue;

  InvoiceId({
    required this.invoiceNo,
    required this.queue,
  });

  @override
  List<Object> get props => [invoiceNo, queue];
}
