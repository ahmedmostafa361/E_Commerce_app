import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utlis/app_assets .dart';
import '../../tabs/favourite_screen.dart';
import '../../tabs/home_screen/home_screen.dart';
import '../../tabs/product_screen/product_screen.dart';
import '../../tabs/profile_screen.dart';
import 'wrapper_screen_states.dart'
    show WrapperScreenInitial, WrapperScreenStates, WrapperScreenIndexChanged;

@injectable
@injectable
class WrapperScreenViewModel extends Cubit<WrapperScreenStates> {
  WrapperScreenViewModel() : super(WrapperScreenInitial());

  int selectedIndex = 0; // just a normal public variable, no get needed

  final navIcons = [
    AppAssets.home,
    AppAssets.category,
    AppAssets.heart,
    AppAssets.user,
  ];

  final List<Widget> selectedWidget = [
    const HomeScreen(),
    const ProductScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex = index; // just update it directly
    emit(WrapperScreenIndexChanged(index)); // this makes the UI rebuild
  }
}
