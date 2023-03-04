import 'package:flutter/material.dart';

class Appscaffold extends StatefulWidget {
  const Appscaffold({Key? key, required this.body, this.title, this.color})
      : super(key: key);
  final Widget body;
  final Widget? title;
  final Color? color;
  @override
  State<Appscaffold> createState() => _AppscaffoldState();
}

class _AppscaffoldState extends State<Appscaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color ?? Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.withOpacity(0.5),
        bottomOpacity: 0,
        shadowColor: Colors.transparent,
        title: widget.title ?? const Text(""),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.brightness_high_sharp,
                color: Theme.of(context).indicatorColor,
              ))
        ],
      ),
      body: widget.body,
    );
  }
}
