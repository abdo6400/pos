import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/invoice_detail.dart';
import '../../../domain/entities/return_invoice_detail.dart';

part 'return_items_state.dart';

class ReturnItemsCubit extends Cubit<ReturnItemsState> {
  ReturnItemsCubit() : super(const ReturnItemsState([], [], []));
  
  // Initialize with invoice items and previously returned items
  void initItems(List<InvoiceDtl> items, [List<returnInvoiceDtl> returnedItems = const []]) {
    // Create a list of item IDs that were previously returned
    final List<String> previouslyReturnedItemIds = returnedItems.map((item) => item.itemId).toList();
    
    // Filter out items that were previously returned
    final List<InvoiceDtl> availableItems = items.where(
      (item) => !previouslyReturnedItemIds.contains(item.item)
    ).toList();
    
    // Items that were previously returned should be in the originallyReturned list
    final List<InvoiceDtl> originallyReturned = items.where(
      (item) => previouslyReturnedItemIds.contains(item.item)
    ).toList();
    
    emit(ReturnItemsState([], availableItems, originallyReturned));
  }

  void returnAllItems() {
    final currentState = state;
    
    // If all items are already in returnItems list, move them back to Items list
    // but don't move originally returned items
    if (currentState.Items.isEmpty && currentState.returnItems.isNotEmpty) {
      // Only move items that are not originally returned
      final updatedItems = List<InvoiceDtl>.from(currentState.returnItems)
        .where((item) => !_isOriginallyReturned(item, currentState.originallyReturned))
        .toList();
      
      // Keep originally returned items in the returnItems list
      final remainingReturnItems = List<InvoiceDtl>.from(currentState.returnItems)
        .where((item) => _isOriginallyReturned(item, currentState.originallyReturned))
        .toList();
      
      emit(ReturnItemsState(remainingReturnItems, updatedItems, currentState.originallyReturned));
    } 
    // Otherwise, move all items to returnItems list
    else if (currentState.Items.isNotEmpty) {
      final updatedReturnItems = List<InvoiceDtl>.from(currentState.returnItems)..addAll(currentState.Items);
      emit(ReturnItemsState(updatedReturnItems, [], currentState.originallyReturned));
    }
  }

  void addToReturnItems(InvoiceDtl item) {
    final currentState = state;
    final updatedReturnItems = List<InvoiceDtl>.from(currentState.returnItems)..add(item);
    final updatedItems = List<InvoiceDtl>.from(currentState.Items)..remove(item);
    emit(ReturnItemsState(updatedReturnItems, updatedItems, currentState.originallyReturned));
  }

  void removeFromReturnItems(InvoiceDtl item) {
    final currentState = state;
    
    // Check if the item was originally returned - if so, don't allow removing it
    if (_isOriginallyReturned(item, currentState.originallyReturned)) {
      return; // Don't allow removing originally returned items
    }
    
    final updatedReturnItems = List<InvoiceDtl>.from(currentState.returnItems)..remove(item);
    final updatedItems = List<InvoiceDtl>.from(currentState.Items)..add(item);
    emit(ReturnItemsState(updatedReturnItems, updatedItems, currentState.originallyReturned));
  }
  
  // Helper method to check if an item is in the originally returned list
  bool _isOriginallyReturned(InvoiceDtl item, List<InvoiceDtl> originallyReturned) {
    return originallyReturned.any((returnedItem) => returnedItem.item == item.item);
  }
}
