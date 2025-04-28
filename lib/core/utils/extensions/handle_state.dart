import '../../utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import '../enums/state_enums.dart';

extension HandleState on BuildContext {
  void handleState(StateEnum state, String? errorMessage) {
    if (state == StateEnum.updating ||
        state == StateEnum.deleting ||
        state == StateEnum.adding) {
      this.showSpinKitOverlayLoader(spinnerType: SpinnerEnum.chasingDots);
      return;
    }
    this.hideOverlayLoader();
    switch (state) {
      case StateEnum.added:
        this.showMessageToast(
          msg: "",
          backgroundColor: Colors.green,
        );
        break;

      case StateEnum.addError || StateEnum.error:
        this.showMessageToast(
          msg: errorMessage!,
          backgroundColor: Colors.red,
        );
        break;

      case StateEnum.deleted:
        this.showMessageToast(
          msg: "",
          backgroundColor: Colors.green,
        );
        break;

      case StateEnum.deleteError:
        this.showMessageToast(
          msg: errorMessage!,
          backgroundColor: Colors.red,
        );
        break;

      case StateEnum.updated:
        this.showMessageToast(
          msg: "",
          backgroundColor: Colors.green,
        );
        break;

      case StateEnum.updateError:
        this.showMessageToast(
          msg: errorMessage!,
          backgroundColor: Colors.red,
        );
        break;
      default:
        break;
    }
  }
}
