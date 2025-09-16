import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_mvvm/src/modules/home/view/home_view.dart';
import 'package:study_flutter_mvvm/src/modules/home/view_model/users_view_model.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<UsersViewModel>(
        create: (context) => UsersViewModel(),
        child: const HomeView(),
      ),
    );
  }
}
