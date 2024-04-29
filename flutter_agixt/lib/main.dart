import 'package:flutter/material.dart';
import 'agixt_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGiXT SDK',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark().copyWith(
          secondary: Colors.yellow,
        ),
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Colors.yellow,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        '/agent-management': (context) => AgentManagementPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AGIXT',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            ListTile(
              title: Text('Agent Management'),
              onTap: () {
                Navigator.of(context).pushNamed('/agent-management');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to AGIXT',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}

class AgentManagementPage extends StatefulWidget {
  @override
  _AgentManagementPageState createState() => _AgentManagementPageState();
}

class _AgentManagementPageState extends State<AgentManagementPage> {
  List<String> providers = [];
  String? selectedProvider;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    setState(() {
      isLoading = true;
    });

    try {
      final agixtSdk = AGiXTSDK();
      providers = await agixtSdk.getProviders();
      if (providers.isNotEmpty) {
        selectedProvider = providers.first;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        providers = ["Unable to retrieve data."];
        selectedProvider = providers.first;
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agent Management',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: selectedProvider,
                    onChanged: (value) {
                      setState(() {
                        selectedProvider = value;
                      });
                    },
                    items: providers.map((provider) {
                      return DropdownMenuItem<String>(
                        value: provider,
                        child: Text(
                          provider,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  if (selectedProvider != null)
                    Text(
                      'Selected Provider: $selectedProvider',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                ],
              ),
            ),
    );
  }
}