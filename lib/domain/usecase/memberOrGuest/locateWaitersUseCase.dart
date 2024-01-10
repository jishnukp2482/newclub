import 'package:newclub/core/usecase.dart';
import 'package:newclub/data/remote/modals/response/locateWaitersResponseModal.dart';
import 'package:newclub/data/repository/app_repository.dart';

class LocateWaiterUseCase
    extends UseCase<LocateWaitersResponseModal, NoParams> {
  final AppRepository appRepository;

  LocateWaiterUseCase(this.appRepository);

  @override
  Future<LocateWaitersResponseModal> call(NoParams params) {
    return appRepository.waiters();
  }
}
