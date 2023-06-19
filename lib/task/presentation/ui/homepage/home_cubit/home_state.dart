abstract class HomeState{}

class HomeInitial extends HomeState{}

class LoadingCategoriesState extends HomeState{}
class LoadedCategoriesState extends HomeState{}
class ErrorLoadingCategoriesState extends HomeState{
  String errorText;

  ErrorLoadingCategoriesState(this.errorText);
}

class LoadHomePercentState extends HomeState{}
class ErrorLoadingHomePercentState extends HomeState{
  String errorText;

  ErrorLoadingHomePercentState(this.errorText);
}



