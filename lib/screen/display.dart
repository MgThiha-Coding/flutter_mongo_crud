import 'package:flutter/material.dart';
import 'package:mongoo/screen/insert.dart';
import 'package:mongoo/service/model/mongomodel.dart';
import 'package:mongoo/service/mongoservice.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display"),
      ),
      body: FutureBuilder(
          future: Mongoservice.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData || snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayCard(snapshot.data[index]);
                      }),
                );
              } else {
                return Center(child: Text('No Data'));
              }
            }
          }),
    );
  }

  Widget displayCard(Mongomodel data) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              data.id.toString(),
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(data.firstName,
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
                Text(data.lastName,
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 43, 2, 2)))
              ],
            ),
            Text(
              data.address,
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Insert();
                            },
                            settings: RouteSettings(arguments: data)));
                  },
                  child: Text('Edit'),
                ),
                MaterialButton(
                  onPressed: () async {
                    await Mongoservice.deleteData(data.id);

                    setState(() {});
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
