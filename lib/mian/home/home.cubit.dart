// ignore_for_file: unused_field
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repository.movie.dart';
import 'home.cubit.state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  final RepositoryMovie repositoryMovie;

  HomeCubit({required this.repositoryMovie})
      : super(const HomeCubitState(status: HomeStatus.initial)) {
    getData();
  }
  getData() async {
    // await Future.delayed(Duration(milliseconds: 100));
    // emit(state.copyWith(status: HomeStatus.loading));
    
    // emit(state.copyWith(status: HomeStatus.success));
  }
}
