import 'package:newclub/core/usecase.dart';
import 'package:newclub/data/remote/modals/request/validateMemberRequestModal.dart';
import 'package:newclub/data/remote/modals/response/validateMemberResponseModal.dart';
import 'package:newclub/data/repository/app_repository.dart';

class ValidateMemberUseCase
    extends UseCase<ValidateMemberResponseModal, ValidateMemberRequestModal> {
  final AppRepository appRepository;

  ValidateMemberUseCase(this.appRepository);

  @override
  Future<ValidateMemberResponseModal> call(ValidateMemberRequestModal params) {
    return appRepository.validateMember(params);
  }
}
