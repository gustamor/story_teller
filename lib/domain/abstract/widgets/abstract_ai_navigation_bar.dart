import 'package:flutter/widgets.dart';

/// Manages the navigation bar in an AI-integrated application.
///
/// This abstract class outlines the structure and behavior of a navigation bar,
/// specifically tailored for applications that incorporate AI features, ensuring 
/// a consistent and intuitive user navigation experience.
abstract class AbstractAiNavigationBar {
  
  /// Gets the list of bottom navigation bar items for Material design.
  ///
  /// These items represent the individual tabs in the bottom navigation bar 
  /// following Material Design guidelines.
  List<BottomNavigationBarItem>? get materialItems;

  /// Gets the list of bottom navigation bar items for Cupertino design.
  ///
  /// These items represent the individual tabs in the bottom navigation bar 
  /// following Cupertino (iOS) design guidelines.
  List<BottomNavigationBarItem>? get cupertinoItems;

  /// Gets the index of the currently active tab in the navigation bar.
  int? get index;

  /// Gets the function to execute when a navigation item is tapped.
  ///
  /// This function updates the UI based on the tapped item's index.
  void Function(int)? get onTapFunction;
}
