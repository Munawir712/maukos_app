import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:maukos_app/app/data/datasources/api_datasources.dart';
import 'package:maukos_app/app/data/datasources/kos_datasource.dart';
import 'package:maukos_app/app/domain/entities/kos/kos_entity.dart';

part 'kos_state.dart';

class KosCubit extends Cubit<KosState> {
  KosCubit(this.kosDataSource) : super(KosInitial());

  final KosDataSource kosDataSource;

  getAllKos({String? param}) async {
    emit(KosLoading());
    final result = await kosDataSource.getAllKos(param: '');
    result.fold(
      (l) => emit(KosFailed(message: l)),
      (r) {
        emit(KosLoaded(kosEntity: r.map((e) => e.toEntity()).toList()));
      },
    );
  }
}
