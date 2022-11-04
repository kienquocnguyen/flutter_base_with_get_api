import 'package:flutter/material.dart';
import 'package:flutterlearning/models/post.dart';
import 'package:flutterlearning/services/remore_sercies.dart';

class Myhome extends StatefulWidget {
  Myhome({Key ? key}) : super(key: key);

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  List<Post>? posts;
  var isLoaded = false;
  
  @override
  void initState(){
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    posts = await RemoteServices().getPosts();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            return Container(
              child: Text(
                posts![index].title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 2
                ),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}