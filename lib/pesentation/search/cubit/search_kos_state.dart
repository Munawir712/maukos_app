part of 'search_kos_cubit.dart';

abstract class SearchKosState extends Equatable {
  const SearchKosState();

  @override
  List<Object> get props => [];
}

class SearchKosInitial extends SearchKosState {}

class SearchKosLoading extends SearchKosState {}

class SearchKosLoaded extends SearchKosState {
  final List<KosEntity> kosEntity;

  const SearchKosLoaded({required this.kosEntity});

  @override
  List<Object> get props => [kosEntity];
}

class SearchKosFailed extends SearchKosState {
  final String message;

  const SearchKosFailed(this.message);
  @override
  List<Object> get props => [message];
}
