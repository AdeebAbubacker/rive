import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
         
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            // TODO: Set mainAxisAlignment
            children: [
              // TODO: Bottom nav items
            ],
          ),
        ),
      ),
    );
  }
}