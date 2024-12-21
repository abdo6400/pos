

import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
 final String page;
 final int totalPages;
 final bool hasMore;

  Pagination({
    required this.page,
    required this.totalPages,
    required this.hasMore,
  });
  
  @override
  List<Object?> get props => [page, totalPages, hasMore];
}
