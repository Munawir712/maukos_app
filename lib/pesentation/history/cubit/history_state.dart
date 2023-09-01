// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryPenyewaanResponseModel> histories;

  const HistoryLoaded(this.histories);
  @override
  List<Object> get props => [histories];
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
