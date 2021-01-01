import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:redux/redux.dart';
import 'package:spacikopooja/store/AppState.dart';
import 'package:spacikopooja/store/actions.dart';
import 'package:spacikopooja/store/notificationHelper.dart';
import 'package:spacikopooja/store/store.dart';
import 'package:spacikopooja/utils/spacikoColor.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
Store<AppState> store;
// ignore: non_constant_identifier_names
bool isSend = false;

class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  @override
  void initState() {
    super.initState();
    main();
  }

  Future<void> main() async {
    await initStore();
    store = getStore();
    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    await initNotifications(flutterLocalNotificationsPlugin);
    requestIOSPermissions(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          setState(() {
            isSend = !isSend;
            _configureDrinkSomeWater(isSend);
          });
        },

        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: spacikoColor.Colorwhite),
          child: Text(isSend?"Off Notification":"Set Notification", style: TextStyle(fontSize: 14,
              fontFamily: 'poppins_regular', color: spacikoColor.Colorblack), textAlign: TextAlign.center),
        ),
      ),
    );
  }

  void _configureDrinkSomeWater(bool value) {
    print('IS_SEND::::$value');

    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(), name: "Hello spaciko App", repeat: RepeatInterval.everyMinute));

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '3', "Hello spaciko App", RepeatInterval.everyMinute);

    } else {
      getStore().dispatch(RemoveReminderAction("Hello spaciko App"));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 3);
    }
  }

  Future<void> scheduleNotificationPeriodically(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, String id, String body,
      RepeatInterval interval) async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(id, 'Reminder notifications',
        'Remember about it', icon: 'smile_icon');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'Reminder', body, interval, platformChannelSpecifics);
  }

  Future<void> turnOffNotificationById(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, num id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

}
