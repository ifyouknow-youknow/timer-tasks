// strings.dart
part of 'datamaster.dart';

mixin _DataMasterStrings {
  String _alertTitle = "Alert Title";
  String _alertText = "Alert Text";

  String get alertTitle => _alertTitle;
  String get alertText => _alertText;

  void setAlertTitle(String value) => _alertTitle = value;
  void setAlertText(String value) => _alertText = value;
}
