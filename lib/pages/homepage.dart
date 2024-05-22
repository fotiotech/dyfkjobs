import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_1/pages/BottomNavBar.dart';
import 'package:flutter_app_1/pages/NavBar.dart';
import 'package:flutter_app_1/pages/square.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _post = ['post 1', 'post 2', 'post 3', 'post 4'];

  String _token = 'Click the below button to generate token';
  bool badgeVisible = true;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getToken() async {
    String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text(
          'Dyfk',
          style: TextStyle(fontSize: 32.0, fontFamily: 'Sans'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //do somthing
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                // color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //do something
              },
              icon: const Icon(
                Icons.notifications,
                size: 30,
                // color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                //do something
              },
              icon: const Icon(
                Icons.settings,
                size: 30,
                // color: Colors.white,
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            child: Center(
              widthFactor: double.infinity,
              heightFactor: double.infinity,
              child: Image.asset('images/nature.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Jobs',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          print('View All pressed');
                        },
                        child: const Text('View All'))
                  ],
                ),
                SizedBox(
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _post.length,
                        itemBuilder: (context, index) {
                          return MySquare(child: _post[index]);
                        }))
              ],
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText('Token: $_token\n'),
              ElevatedButton(
                onPressed: getToken,
                child: const Text('Get new token'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  if (badgeVisible) {
                    GRecaptchaV3.hideBadge();
                  } else {
                    GRecaptchaV3.showBadge();
                  }
                  badgeVisible = !badgeVisible;
                },
                icon: const Icon(Icons.legend_toggle),
                label: const Text("Toggle Badge Visibilty"),
              ),
              TextButton.icon(
                  label: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(
                        text: "https://pub.dev/packages/g_recaptcha_v3"));
                  },
                  icon: const SelectableText(
                      "https://pub.dev/packages/g_recaptcha_v3")),
            ],
          )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

Future displayBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
            height: 300,
          ));
}
