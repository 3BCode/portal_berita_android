import "package:flutter/material.dart";

class AboutHome extends StatefulWidget {
  const AboutHome({super.key});

  @override
  State<AboutHome> createState() => _AboutHomeState();
}

class _AboutHomeState extends State<AboutHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("About User"),
      ),
    );
  }
}
