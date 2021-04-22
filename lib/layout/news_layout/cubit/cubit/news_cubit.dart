import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/layout/news_layout/news_layout.dart';
import 'package:news_app/modules/business/business_screens.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/since/since_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Buisness',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Scince',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void chandeCurrntOndex(index) {
    currentIndex = index;
    emit(NewsBottomNav());
  }

  List<Widget> scrrens = [
    BusinessScreen(),
    SportsScreen(),
    SinceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];

  void getBuisness() {
    emit(NewsLoadingBuisnesState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '5a7bc3e3da2a46679343a7b343496833'
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError(
      (error) {
        print(error);
        emit(NewsGetBusinessErrorState(error.toString()));
      },
    );
  }

  void getSports() {
    emit(NewsLoadingSportsState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apikey': '5a7bc3e3da2a46679343a7b343496833'
    }).then((value) {
      sports = value.data['articles'];
      print(business[0]['title']);
      emit((NewsGetSportsSuccessState()));
    }).catchError(
      (error) {
        print(error);
        emit(NewsGetSportsErrorState(error.toString()));
      },
    );
  }
}
