

import 'package:event_bus/event_bus.dart';

class EventBusUtils {

  static EventBus _instance = EventBus() ;

  static EventBus getInstance() {

    if (null == _instance) {
      _instance = EventBus();
    }
    return _instance;
  }
}