import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/round_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'APOD'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to Astronomy Picture of the Day!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  height: 150,
                ),
                RoundButton(
                  label: "Select datetime",
                  onTap: () async {
                    var datePicked = await showDatePicker(
                      helpText: "Select a datetime",
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1995, 06, 16),
                      lastDate: DateTime.now(),
                    ).then((value) => {
                          if (value != null)
                            {
                              Modular.to.pushNamed("/picture",
                                  arguments: {'dateSelected': value})
                            }
                        });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
