// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import 'package:hive_example/model/model.dart';

class CarAdapter extends TypeAdapter<CarModel> {
  @override
  void write(BinaryWriter writer, CarModel obj) {
    writer.write(obj.name);
    writer.write(obj.brand);
    writer.write(obj.price);
  }

  @override
  CarModel read(BinaryReader reader) {
    final name = reader.read() as String;
    final brand = reader.read() as String;
    final price = reader.read() as num;

    return CarModel(
      name: name,
      brand: brand,
      price: price,
    );
  }

  @override
  int typeId = 0;
}
