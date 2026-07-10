import 'package:e_commerce_flutter_app/domain/entinties/response/whishlist/get_whish_list_response.dart';

import '../../../../../../domain/entinties/response/whishlist/add_whish_list_response.dart';

sealed class AddWhishListStates {}

class WhishListInitialStates extends AddWhishListStates {}

class AddWhishListLoadingState extends AddWhishListStates {}

class AddWhishListSuccessState extends AddWhishListStates {
  final AddWhishListResponse response;

  AddWhishListSuccessState({required this.response});
}

class AddWhishListErrorState extends AddWhishListStates {
  final String message;

  AddWhishListErrorState({required this.message});
}

/// get whishList states

class GetWhishListLoadingState extends AddWhishListStates {}

class GetWhishListSuccessState extends AddWhishListStates {
  GetWhishListResponse getWhishListResponse;

  GetWhishListSuccessState({required this.getWhishListResponse});
}

class GetWhishListErrorState extends AddWhishListStates {
  final String message;

  GetWhishListErrorState({required this.message});
}

/// delete whishlist states

class DeleteItemInWhishListLoadingState extends AddWhishListStates {}

class DeleteItemInWhishListSuccessState extends AddWhishListStates {
  GetWhishListResponse getWhishListResponse;

  DeleteItemInWhishListSuccessState({required this.getWhishListResponse});
}

class DeleteItemInWhishListErrorState extends AddWhishListStates {
  final String message;

  DeleteItemInWhishListErrorState({required this.message});
}
