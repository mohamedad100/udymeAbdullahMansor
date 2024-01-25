
import '../../../../models/shop_app/login_model.dart';
import '../../../../models/shop_app/register_model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterSuccessState extends ShopRegisterState{
  ShopRegisterModel? loginRegisterModel;
  ShopRegisterSuccessState(this.loginRegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState{}
