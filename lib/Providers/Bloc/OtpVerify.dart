import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Events
abstract class OtpVerificationEvent {}

class OtpEnteredEvent extends OtpVerificationEvent {
  final String enteredOtp;

  OtpEnteredEvent(this.enteredOtp);
}

// States
abstract class OtpVerificationState {}

class InitialOtpVerificationState extends OtpVerificationState {}

class OtpVerificationSuccessState extends OtpVerificationState {}

class OtpVerificationFailureState extends OtpVerificationState {
  final String errorMessage;

  OtpVerificationFailureState(this.errorMessage);
}

// BLoC
class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final String verificationId;

  OtpVerificationBloc(this.verificationId)
      : super(InitialOtpVerificationState());

  @override
  Stream<OtpVerificationState> mapEventToState(
      OtpVerificationEvent event) async* {
    if (event is OtpEnteredEvent) {
      // Business logic to verify OTP
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: event.enteredOtp,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        yield OtpVerificationSuccessState();
      } catch (ex) {
        yield OtpVerificationFailureState(
        'Failed to verify OTP. Please try again.');
      }
    }
  }
}
