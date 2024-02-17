import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';
import 'package:blogpost/module/notification/presentation/state/bloc/notification_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  String getName(NotificationTopic topic){
    switch (topic) {
      case NotificationTopic.newpost:
        return "New post";
      case NotificationTopic.like:
        return "Like my post";
      case NotificationTopic.comment:
        return "Comment my post";
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationSettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
        bloc: bloc,
        builder: (context, state) {
          final widgets = <Widget>[];
          state.settings.forEach((key, value) {
            widgets.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getName(key),
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Switch(
                    trackOutlineColor: const MaterialStatePropertyAll(Colors.black),
                    activeColor: Colors.black,
                    activeTrackColor: Colors.white,
                    value: value, 
                    onChanged: (flag) => bloc.add(NotificationSettingsUpdateSettingEvent(topic: key, isEnable: flag))
                  ),
                ],
              )
            );
          });
          return Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: widgets,
            ),
          );
        },
      ),
    );
  }
}
