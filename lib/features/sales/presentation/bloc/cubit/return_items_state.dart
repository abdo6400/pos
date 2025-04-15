part of 'return_items_cubit.dart';

class ReturnItemsState extends Equatable {
  final List<InvoiceDtl> returnItems;
  final List<InvoiceDtl> Items;
  
  const ReturnItemsState(
    this.returnItems,
    this.Items,
  );

  @override
  List<Object> get props => [returnItems, Items];
}




