import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class First extends ConsumerStatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _NotFoundState createState() => _NotFoundState();
}

class _NotFoundState extends ConsumerState<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            "This is First Page ",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
