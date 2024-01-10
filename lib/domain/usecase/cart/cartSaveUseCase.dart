import 'package:newclub/core/usecase.dart';
import 'package:newclub/data/remote/modals/request/cartsaveRequestModal.dart';
import 'package:newclub/data/remote/modals/response/cartSaveResponseModal.dart';
import 'package:newclub/data/repository/app_repository.dart';

class CartSaveUseCase
    extends UseCase<CartSaveResponseModal, CartSaveRequestModal> {
  final AppRepository appRepository;

  CartSaveUseCase(this.appRepository);

  @override
  Future<CartSaveResponseModal> call(CartSaveRequestModal params) {
    return appRepository.cartSave(params);
  }
}
