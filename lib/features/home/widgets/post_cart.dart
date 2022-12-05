import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/others/utils/utils.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:flutter/material.dart';

class PostCart extends StatefulWidget {
  final snap;

  const PostCart({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCart> createState() => _PostCartState();
}

class _PostCartState extends State<PostCart> {
  var postData = {};
  bool isLoading = false;
  String name = '';

  /////////////////////////////////////////////////////////////////////////////

  getData() async {
    isLoading = true;
    try {
      var postSnap =
          await FirebaseFirestore.instance.collection('posts').doc().get();

      postData = postSnap.data()!;

      name = postSnap.data()!['name'];

      setState(() {});
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ClassTheme.drawerColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 23.0,
                      backgroundImage: NetworkImage(
                        widget.snap['profImage'],
                      ), //profimage
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 4),
                          child: Row(
                            children: [
                              Text(widget.snap['name']), //name
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.snap['lastName']) //lastname
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              '6hr',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade600),
                            ), //name
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.group,
                              size: 15,
                              color: Colors.grey.shade500,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: double.infinity,

            //if (widget.snap['postUrl'] == widget.snap[''],)
            child: Image.network(
              widget.snap['postUrl'],
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
