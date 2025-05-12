import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/usecases/upload_pending_invoices_usecase.dart';

part 'pending_invoices_event.dart';
part 'pending_invoices_state.dart';

class PendingInvoicesBloc
    extends Bloc<PendingInvoicesEvent, PendingInvoicesState> {
  final UploadPendingInvoicesUsecase _uploadPendingInvoicesUsecase;
  PendingInvoicesBloc(this._uploadPendingInvoicesUsecase)
      : super(PendingInvoicesInitial()) {
    on<PendingInvoicesEventUploaded>((event, emit) async {
      final user = (await storage.getUser())!;
      await _uploadPendingInvoicesUsecase.call(UploadPendingInvoicesParams(
          branchId: int.parse(user.defaultBranch), userNo: user.userNo));
    });
  }
}
