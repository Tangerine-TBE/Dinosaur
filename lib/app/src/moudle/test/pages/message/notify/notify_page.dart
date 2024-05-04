import 'package:flutter/material.dart';
class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('notify'),);
  }

  @override
  bool get wantKeepAlive => true;
}



