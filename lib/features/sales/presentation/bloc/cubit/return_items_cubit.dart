import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/invoice_detail.dart';

part 'return_items_state.dart';

class ReturnItemsCubit extends Cubit<ReturnItemsState> {
  ReturnItemsCubit() : super(const ReturnItemsState([], []));

  void initItems(List<InvoiceDtl> items) {
    emit(ReturnItemsState([], items));
  }

  void returnAllItems() {
    final currentState = state;
    
    // If all items are already in returnItems list, move them back to Items list
    if (currentState.Items.isEmpty && currentState.returnItems.isNotEmpty) {
      final updatedItems = List<InvoiceDtl>.from(currentState.returnItems);
      emit(ReturnItemsState([], updatedItems));
    } 
    // Otherwise, move all items to returnItems list
    else if (currentState.Items.isNotEmpty) {
      final updatedReturnItems = List<InvoiceDtl>.from(currentState.Items);
      emit(ReturnItemsState(updatedReturnItems, []));
    }
  }

  void addToReturnItems(InvoiceDtl item) {
    final currentState = state;
    final updatedReturnItems = List<InvoiceDtl>.from(currentState.returnItems)..add(item);
    final updatedItems = List<InvoiceDtl>.from(currentState.Items)..remove(item);
    emit(ReturnItemsState(updatedReturnItems, updatedItems));
  }

  void removeFromReturnItems(InvoiceDtl item) {
    final currentState = state;
    final updatedReturnItems = List<InvoiceDtl>.from(currentState.returnItems)..remove(item);
    final updatedItems = List<InvoiceDtl>.from(currentState.Items)..add(item);
    emit(ReturnItemsState(updatedReturnItems, updatedItems));
  }
}
