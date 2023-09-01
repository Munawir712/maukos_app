part of 'kos_cubit.dart';

abstract class KosState extends Equatable {
  const KosState();

  @override
  List<Object> get props => [];
}

class KosInitial extends KosState {}

class KosLoading extends KosState {}

class KosLoaded extends KosState {
  final List<KosEntity> kosEntity;

  const KosLoaded({required this.kosEntity});

  @override
  List<Object> get props => [kosEntity];
}

class KosFailed extends KosState {
  final String message;

  const KosFailed({required this.message});

  @override
  List<Object> get props => [message];
}
