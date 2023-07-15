// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/adapters/car_adapter.dart';
import 'package:hive_example/model/model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox("vegetables");
  Hive.registerAdapter(CarAdapter());
  await Hive.openBox("gm");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController brand = TextEditingController();
    TextEditingController price = TextEditingController();
    final gm = Hive.box("gm");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Hive Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GENERAL MOTORS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Name")),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Brand"),
                  ),
                  controller: brand,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Price"),
                  ),
                  controller: price,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: gm.values.length,
              itemBuilder: (context, index) {
                List<CarModel> cars = gm.values.toList().cast();
                return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple),
                  child: ListTile(
                    title: Text(
                      cars[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      cars[index].price.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gm.add(
            CarModel(
              name: name.text,
              brand: brand.text,
              price: int.parse(price.text),
            ),
          );
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
