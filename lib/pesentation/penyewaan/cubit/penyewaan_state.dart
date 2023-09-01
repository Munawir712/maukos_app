// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'penyewaan_cubit.dart';

abstract class PenyewaanState extends Equatable {
  const PenyewaanState();

  @override
  List<Object> get props => [];
}

class PenyewaanInitial extends PenyewaanState {}

class PenyewaanLoading extends PenyewaanState {}

class PenyewaanSuccess extends PenyewaanState {
  final String message;

  const PenyewaanSuccess(this.message);
}

class PenyewaanError extends PenyewaanState {
  final String message;
  const PenyewaanError({
    required this.message,
  });
}
