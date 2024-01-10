import 'package:newclub/core/usecase.dart';
import 'package:newclub/data/remote/modals/response/locateCounterResponseModal.dart';
import 'package:newclub/data/repository/app_repository.dart';

class LocateCounterUseCase
    extends UseCase<LocateCounterResponseModal, NoParams> {
  final AppRepository appRepository;

  LocateCounterUseCase(this.appRepository);

  @override
  Future<LocateCounterResponseModal> call(NoParams params) {
    final data = appRepository.counter();
    print("locate counter usecase==$data");
    return data;
  }
}
