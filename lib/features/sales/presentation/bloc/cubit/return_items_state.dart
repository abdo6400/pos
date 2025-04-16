part of 'return_items_cubit.dart';

class ReturnItemsState extends Equatable {
  final List<InvoiceDtl> returnItems;
  final List<InvoiceDtl> Items;
  final List<InvoiceDtl> originallyReturned;
  
  const ReturnItemsState(
    this.returnItems,
    this.Items,
    this.originallyReturned,
  );

  @override
  List<Object> get props => [returnItems, Items, originallyReturned];
}




