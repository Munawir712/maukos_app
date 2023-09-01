import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/datasources/history_datasource.dart';
import 'package:maukos_app/app/data/models/history/history_penyewaan_response_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.historyDataSource) : super(HistoryInitial());

  HistoryDataSource historyDataSource;

  getAllHistory() async {
    emit(HistoryLoading());
    final result = await historyDataSource.getAllHistory();

    result.fold(
      (l) => emit(HistoryError(message: l)),
      (r) => emit(HistoryLoaded(r)),
    );
  }

  cancelPenyewaan(int penyewaanId) async {
    emit(HistoryLoading());

    final result =
        await historyDataSource.cancelPenyewaan(penyewaanId: penyewaanId);
    result.fold(
      (l) => emit(HistoryError(message: l)),
      (r) {
        log(r.message);
        getAllHistory();
      },
    );
  }
}
