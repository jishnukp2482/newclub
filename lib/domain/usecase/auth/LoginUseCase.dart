import 'package:newclub/core/usecase.dart';
import 'package:newclub/data/remote/modals/request/loginRequestModal.dart';
import 'package:newclub/data/remote/modals/response/loginresponseModal.dart';
import 'package:newclub/data/repository/app_repository.dart';

class LoginUseCase extends UseCase<LoginResponseModal, LoginRequestModal> {
  final AppRepository appRepository;

  LoginUseCase(this.appRepository);

  @override
  Future<LoginResponseModal> call(LoginRequestModal params) {
    return appRepository.login(params);
  }
}
