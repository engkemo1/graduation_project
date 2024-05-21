abstract class HomeMainState {}

class HomeMainInitialState extends HomeMainState{}
class UpComingEventsLoadingState extends HomeMainState{}
class UpComingEventsSuccessState extends HomeMainState{}

class UpComingEventsErrorState extends HomeMainState{
  final  error;

  UpComingEventsErrorState(this.error);
}


class PopularLoadingState extends HomeMainState{}
class PopularSuccessState extends HomeMainState{}

class PopularErrorState extends HomeMainState{
  final  error;

  PopularErrorState(this.error);
}
class CategoryLoadingState extends HomeMainState{}
class CategorySuccessState extends HomeMainState{}

class CategoryErrorState extends HomeMainState{
  final  error;

  CategoryErrorState(this.error);
}
class SubCategoryLoadingState extends HomeMainState{}
class SubCategorySuccessState extends HomeMainState{}

class SubCategoryErrorState extends HomeMainState{
  final  error;

  SubCategoryErrorState(this.error);
}