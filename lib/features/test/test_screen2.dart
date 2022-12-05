import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({Key? key}) : super(key: key);

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  Future setData({required String name}) async {
    setState(() {
      isLoading = true;
    });
    final doc = FirebaseFirestore.instance.collection('musica').doc();

    Map<String, dynamic> json = {"name": name};

    await doc.set(json);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'name',
                    hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            ElevatedButton.icon(
                label: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 135.0, vertical: 15),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text('Button'),
                ),
                onPressed: () => setData(name: controller.text),
                icon: const Icon(Icons.play_arrow)),

            //////////////////////////////////////////////////////////////////////////
            SizedBox(
              height: 500,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bandnames')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          buildListItem(context, snapshot.data!.docs[index]));
                },
              ),
            ),
            ////////////////////////////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
Widget buildListItem(BuildContext context, DocumentSnapshot document) {
  return ListTile(
    title: Row(
      children: [
        Text(document['name']),
        const SizedBox(
          width: 10,
        ),
        Text(document['votes'].toString())
      ],
    ),
  );
}
