import 'dart:ffi';

import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ///////////////////////////////////////////////////////////////
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(30),
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(40, 1, 4, 14),
                    Color(0xffF2DD22)
                  ])),
              child: const Text('HOLA'),
            ),
            ///////////////////////////////////////////////////////////////
            Container(
              margin: const EdgeInsets.all(10),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  // borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 20, color: Colors.pinkAccent),
                  shape: BoxShape.circle),
            ),
            ///////////////////////////////////////////////////////////////
            ElevatedButton(
              onPressed: () {},
              child: Text('button '),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            ///////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            /////////////////////////////////////////////////////////////////
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.password),
                    prefixIcon: Icon(Icons.play_arrow),
                    icon: Icon(Icons.abc),
                    labelText: 'Password',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2)),
                    hintText: 'USERNAME',
                    fillColor: Colors.black),
              ),
            ),
            ////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.holiday_village),
                label: const Text('helo')),
            ////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            ///////////////////////////////////////////////
            ClipOval(
              child: Image.network(
                  'https://cdn.pixabay.com/photo/2017/06/11/00/05/girl-2391171_960_720.jpg'),
            ),
            const Divider(
              thickness: 5,
            ),
            /////////////////////////////////////////////////////////////
            const AlertDialog(),
            // DropdownButton(items: [], onChanged: null),
            const Icon(Icons.call),
            Wrap(
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.holiday_village),
                    label: const Text('helo')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.holiday_village),
                    label: const Text('helo')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.holiday_village),
                    label: const Text('helo')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.holiday_village),
                    label: const Text('helo')),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.holiday_village),
                    label: const Text('helo')),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  // itemCount: ,
                  itemBuilder: (context, index) {
                return const Text('hello');
              }),
            ),

            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                  Icon(
                    Icons.hourglass_bottom,
                    size: 200,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView(scrollDirection: Axis.vertical, children: const [
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
                Icon(
                  Icons.hourglass_bottom,
                  size: 200,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
