import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum CallState { initial, loading, success, error }

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallState.initial);

  Future<void> makePhoneCall(String phoneNumber) async {
    emit(CallState.loading);
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
      emit(CallState.success);
    } else {
      emit(CallState.error);
    }
  }

  Future<void> openWhatsApp({
    required String whatsAppNumber,
    required String message,
  }) async {
    emit(CallState.loading);

    final Uri url = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: whatsAppNumber,
      queryParameters: {'text': 'Hello'},
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      emit(CallState.success);
    } else {
      emit(CallState.error);
    }
  }
}
