import 'package:flutter/material.dart';
import 'package:mongoo/screen/display.dart';
import 'package:mongoo/service/model/mongomodel.dart';
import 'package:mongoo/service/mongoservice.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Insert extends StatefulWidget {
  const Insert({
    super.key,
  });

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController addressController;
  Mongomodel? data;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    addressController = TextEditingController();

    // Check if data is passed via arguments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = ModalRoute.of(context)?.settings.arguments as Mongomodel?;
      if (data != null) {
        // Populate controllers if data exists (Update mode)
        fnameController.text = data!.firstName;
        lnameController.text = data!.lastName;
        addressController.text = data!.address;
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is destroyed
    fnameController.dispose();
    lnameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> insertData(
      String firstName, String lastName, String address) async {
    var _id = M.ObjectId();
    final data = Mongomodel(
        id: _id, firstName: firstName, lastName: lastName, address: address);
    await Mongoservice.insert(data);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Display()));
    clear();
  }

  Future<void> updateData(
      var id, String firstName, String lastName, String address) async {
    final updateData = Mongomodel(
        id: id, firstName: firstName, lastName: lastName, address: address);
    await Mongoservice.update(updateData);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Display()));
    clear();
  }

  void clear() {
    // Clear the text fields
    fnameController.clear();
    lnameController.clear();
    addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mongoo',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 11, 51),
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: fnameController,
                decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: lnameController,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      insertData(fnameController.text, lnameController.text,
                          addressController.text);
                    },
                    child: Text(
                      "Insert",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    color: const Color.fromARGB(255, 47, 2, 88),
                    onPressed: () {
                      updateData(data!.id, fnameController.text,
                          lnameController.text, addressController.text);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 242, 242, 245)),
                    ),
                  ),
                  SizedBox(width: 10),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Display()));
                    },
                    child: Text(
                      'View Data',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
