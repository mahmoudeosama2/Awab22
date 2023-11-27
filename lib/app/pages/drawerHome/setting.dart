import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran2/app/statemanagment/otherProviders.dart';
import 'package:workmanager/workmanager.dart';
import '../../../start/splashscreen.dart';
import '../../customewidget/CustomAppBarwithIcon.dart';
import '../../services/sharedprefrances.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<Other>(context);
    bool switched = model.isswitch!;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBarWithIcon(icon: Icons.settings),
            Container(
              //  color: Colors.red,
              child: ListTile(
                // isThreeLine: true,
                trailing: Text(
                  "تشغيل الاشعارات",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: Switch(
                    activeColor: Colors.white,
                    activeTrackColor: Theme.of(context).primaryColor,
                    value: switched,
                    onChanged: (value) {
                      setState(()  {
                        if (switched == true) {
                          changeBoolPrefs("notificationSwitch", false);
                       
                           Workmanager().cancelAll();
                          model.isswitch = false;
                        } else if (switched == false) {
                          Workmanager().initialize(callbackDispatcher);

                          Workmanager().registerPeriodicTask(
                            "1",
                            "",
                            frequency: const Duration(minutes: 15),
                          );
                          changeBoolPrefs("notificationSwitch", true);
                          model.isswitch = true;
                        }
                      });
                    }),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       sss();
            //     },
            //     child: Text("data"))
          ],
        ));
  }
}
