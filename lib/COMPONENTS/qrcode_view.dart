import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends StatefulWidget {
  final String data;
  final double size;
  const QrcodeView(
      {super.key,
      this.data = "https://innovativeinternetcreations.com",
      this.size = 150});

  @override
  State<QrcodeView> createState() => _QrcodeViewState();
}

class _QrcodeViewState extends State<QrcodeView> {
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: widget.data,
      version: QrVersions.auto,
      size: widget.size,
    );
  }
}
