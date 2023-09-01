import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/data/datasources/kos_datasource.dart';
import '../../../app/domain/entities/kos/kos_entity.dart';

part 'search_kos_state.dart';

class SearchKosCubit extends Cubit<SearchKosState> {
  SearchKosCubit(this.kosDataSource) : super(SearchKosInitial());

  final KosDataSource kosDataSource;

  searchKos(String alamat) async {
    emit(SearchKosLoading());
    final result = await kosDataSource.getAllKos(param: alamat);
    result.fold(
      (l) => emit(SearchKosFailed(l)),
      (r) {
        emit(SearchKosLoaded(kosEntity: r.map((e) => e.toEntity()).toList()));
      },
    );
  }
}
