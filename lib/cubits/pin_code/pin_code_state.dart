class PinCodeState {
  final bool enterFinger;
  final String button;
  final String pinCode;

  PinCodeState(
      {required this.enterFinger, required this.button, required this.pinCode});

  PinCodeState copyWith({
    bool? enterFinger,
    String? button,
    String? pinCode,
  }) {
    return PinCodeState(
      enterFinger: enterFinger ?? this.enterFinger,
      button: button ?? this.button,
      pinCode: pinCode ?? this.pinCode,
    );
  }
}
