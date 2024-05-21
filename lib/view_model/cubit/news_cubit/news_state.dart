abstract class NewsMainState {}

class NewsMainInitialState extends NewsMainState{}
class NewsLoadingState extends NewsMainState{}
class NewsSuccessState extends NewsMainState{}

class NewsErrorState extends NewsMainState{
  final  error;

  NewsErrorState(this.error);
}


