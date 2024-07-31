import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dropkick_app/screens/screens.dart';
import 'package:intl/intl.dart';
import 'data/GraphQlConfig.dart';
import 'data/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.clientToQuery(),
      child: MaterialApp(
        title: 'Dropkick.io',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: kBackgroundColour,
          primaryColor: kPrimaryColour,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColour),
        ),
        initialRoute: '/homeScreen',
        routes: {
          '/homeScreen': (context) => HomeScreen(),
        },
      ),
    );
  }
}
