import '../../config/database/api/api_keys.dart';
import '../entities/pagination.dart';

class PaginationModel extends Pagination {
  PaginationModel(
      {required super.page, required super.totalPages, required super.hasMore});

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        page: json[ApiKeys.page],
        totalPages: json[ApiKeys.totalPages],
        hasMore: json[ApiKeys.hasMore],
      );
}
