import 'package:bloc_example/cubits/pin_code/pin_code_state.dart';
import 'package:bloc_example/data/storage_repository/storage_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  PinCodeCubit()
      : super(
          PinCodeState(enterFinger: false, button: "", pinCode: ''),
        );

  String pin = StorageRepository.getString(key: "pin_code");

  void enterFinger(bool v) {
    emit(state.copyWith(enterFinger: v));
  }

  void setButton(String v) async {
    if (state.pinCode.length < 4) {
      String pinCode = state.pinCode;
      emit(state.copyWith(pinCode: pinCode += v));
      print(state.pinCode);
      if (pin.isNotEmpty) {
        debugPrint("cubit true");
      } else {
        debugPrint("cubit false");
        if(state.pinCode.length == 4){
          debugPrint("storage true");
          await StorageRepository.setString(key: "pin_code", value: state.pinCode);
        }
      }
    }
  }

  void deleteButton() {
    if (state.pinCode.isNotEmpty) {
      emit(state.copyWith(
          pinCode: state.pinCode.substring(0, state.pinCode.length - 1)));
    }
  }

  bool checkPassword() {
    if (state.pinCode == pin) {
      return true;
    } else {
      return false;
    }
  }
}
