abstract class NotificationMainState {}

class NotificationMainInitialState extends NotificationMainState{}
class NotificationLoadingState extends NotificationMainState{}

class NotificationSuccessState extends NotificationMainState{}

class NotificationErrorState extends NotificationMainState{
  final  error;

  NotificationErrorState(this.error);
}
