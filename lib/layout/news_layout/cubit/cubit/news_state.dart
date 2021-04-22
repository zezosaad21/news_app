part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsBottomNav extends NewsState {}

class NewsLoadingBuisnesState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsLoadingSportsState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  final String error;

  NewsGetSportsErrorState(this.error);
}
