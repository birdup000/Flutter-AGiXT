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
          headline6: TextStyle(
            color: Colors.yellow,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: ProviderScreen(),
    );
  }
}

class ProviderScreen extends StatefulWidget {
  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
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
          'AGIXT',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
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