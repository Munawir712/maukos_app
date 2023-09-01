import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/datasources/penyewaan_datasource.dart';
import 'package:maukos_app/app/data/models/penyewaan/penyewaan_request_model.dart';

part 'penyewaan_state.dart';

class PenyewaanCubit extends Cubit<PenyewaanState> {
  PenyewaanCubit(this.penyewaanDataSource) : super(PenyewaanInitial());

  PenyewaanDataSource penyewaanDataSource;
  Future<void> sewa(PenyewaanRequestModel request) async {
    emit(PenyewaanLoading());
    final result = await penyewaanDataSource.sewaKos(request);

    result.fold(
      (l) => emit(PenyewaanError(message: l.message)),
      (r) => emit(PenyewaanSuccess(r.message)),
    );
  }
}
