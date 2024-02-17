import 'package:bloc/bloc.dart';
import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';
import 'package:blogpost/module/notification/domain/interactor/notification_interactor.dart';
import 'package:meta/meta.dart';

part 'notification_settings_event.dart';
part 'notification_settings_state.dart';

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  
  final NotificationInteractor _notificationInteractor;

  NotificationSettingsBloc(
    this._notificationInteractor
  ) : super(NotificationSettingsState()) {
    on<NotificationSettingsLoadEvent>(_load);
    on<NotificationSettingsUpdateSettingEvent>(_update);
  }

  void _load(
    NotificationSettingsLoadEvent event, 
    Emitter<NotificationSettingsState> emit
  ){
    final settings = _notificationInteractor.getSettings();
    emit(state.copyWith(settings: settings));
  } 

  void _update(
    NotificationSettingsUpdateSettingEvent event, 
    Emitter<NotificationSettingsState> emit
  ){
    if(event.isEnable){
      _notificationInteractor.subscribe(event.topic);
    } else {
      _notificationInteractor.unsubscribe(event.topic);
    }
    emit(state.copyWith(settings: state.settings..addAll({
      event.topic: event.isEnable
    })));
  } 
}
