import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash.bloc.event.dart';
import 'splash.bloc.state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashStateInitial()) {
    on<SaveImageGiftToCacheEvent>(_handleSaveImageGiftToCache);
  }
  Future<void> _handleSaveImageGiftToCache(
      SaveImageGiftToCacheEvent event, Emitter<SplashState> emit) async {
  }
}
