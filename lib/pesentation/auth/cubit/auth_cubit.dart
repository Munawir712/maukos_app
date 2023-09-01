import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maukos_app/app/data/datasources/api_datasources.dart';
import 'package:maukos_app/app/data/models/auth/login_model.dart';
import 'package:maukos_app/app/data/models/auth/register_model.dart';
import 'package:maukos_app/app/domain/entities/auth/user_entity.dart';
import 'package:maukos_app/core/localstorage/localstorage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.apiDataSources}) : super(AuthInitial());

  final ApiDataSources apiDataSources;

  void login(LoginModel request) async {
    emit(AuthLoading());

    final result = await apiDataSources.login(request);

    result.fold(
      (l) => emit(AuthError(l)),
      (r) async {
        await LocalStorage.storeCredentialToLocal(
          r.toEntity(),
          request.password,
        );
        return emit(AuthLoaded(user: r.toEntity()));
      },
    );
  }

  void getCurrentUser() async {
    final response = await LocalStorage.getCredentialFromLocal();
    response.fold(
      (l) => emit(AuthError(l)),
      (r) {
        login(LoginModel(r.username, r.password));
      },
    );
  }

  void register(RegisterModel request) async {
    emit(AuthLoading());
    final response = await apiDataSources.register(request);

    response.fold(
      (l) => emit(AuthError(l)),
      (r) => emit(AuthRegisterSuccess(message: r.message)),
    );
  }

  void logout() async {
    emit(AuthLoading());
    await LocalStorage.clearLocalStorage();
    emit(AuthInitial());
  }
}
