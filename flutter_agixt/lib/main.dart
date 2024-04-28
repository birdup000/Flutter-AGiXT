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
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        providers = ["Unable to retrieve data."];
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AGiXT SDK'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(providers[index]),
                );
              },
            ),
    );
  }
}