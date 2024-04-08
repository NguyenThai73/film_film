// ignore_for_file: unused_field
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/repository.movie.dart';
import 'popula.cubit.state.dart';

class PopulaCubit extends Cubit<PopulaCubitState> {
  final RepositoryMovie repositoryMovie;
  PopulaCubit({required this.repositoryMovie})
      : super(const PopulaCubitState(status: Status.initial, listMovie: [])) {
    getData();
  }
  getData() async {
    emit(state.copyWith(status: Status.loading));
    await repositoryMovie.getPopular();
    if (repositoryMovie.listPopular != null &&
        repositoryMovie.listPopular?.results != null &&
        repositoryMovie.listPopular!.results!.isNotEmpty) {
      if (repositoryMovie.listPopular!.results!.length > 10) {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listPopular!.results!.sublist(0, 15)));
      } else {
        emit(state.copyWith(
            status: Status.success,
            listMovie: repositoryMovie.listPopular!.results!));
      }
    } else {
      emit(state.copyWith(status: Status.success, listMovie: []));
    }
  }
}
