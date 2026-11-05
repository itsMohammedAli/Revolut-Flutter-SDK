import 'package:flutter/material.dart';
import 'package:revolut_sdk_bridge/revolut_sdk_bridge.dart';

class PluginTest extends StatefulWidget {
  const PluginTest({super.key});
  @override
  State<PluginTest> createState() => _PluginTestState();
}

class _PluginTestState extends State<PluginTest> {
  Map<String, dynamic>? _status;
  bool _loading = false;
  Future<void> _refresh() async {
    setState(() => _loading = true);
    final status = await RevolutSdkBridge().getPluginStatus();
    if (!mounted) return;
    setState(() {
      _status = status;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('SDK Status')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_loading) const LinearProgressIndicator(),
          if (_status != null) SelectableText(_status.toString()),
          ElevatedButton(
            onPressed: _loading ? null : _refresh,
            child: const Text('Refresh status'),
          ),
        ],
      ),
    ),
  );
}
