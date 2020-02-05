import 'package:hive/hive.dart';

/// Specify [class_name].g.dart before running
/// "flutter packages pub run build_runner build"
part 'place.g.dart';

/// Base Class for PlaceApapter
/// Run "flutter packages pub run build_runner build" after creating base classes.
///
/// This class is the "Table" or as we call it "Box" in hive

@HiveType(typeId: 0)
class Place {

  @HiveField(0)
  String name;

  Place(this.name);

}