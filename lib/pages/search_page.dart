import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soccer_app/providers/auth_provider.dart';
import 'package:soccer_app/providers/chat_provider.dart';
import 'package:soccer_app/services/services.dart';
import 'package:soccer_app/widgets/search.dart';

class SearchPage extends StatefulWidget {
  static const id = "search";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _search = TextEditingController();

  Stream<QuerySnapshot<Object?>> data = Stream.empty();
  @override
  Widget build(BuildContext context) {
    var chatProvider = Provider.of<ChatProvider>(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SearchInput(
          _search,
          "Search",
          250,
          Ionicons.search_outline,
          onSubmit: (val) async {
            FocusScope.of(context).requestFocus(FocusNode());
            if (_search.text.isNotEmpty) {
              var userr = await chatProvider.search(_search.text);
              setState(() {
                data = userr;
                _search.text = '';
              });
            }
          },
        ),
        elevation: 0,
      ),
      body: searchfrouser(chatProvider),
    );
  }

  Widget searchfrouser(chatProvider) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: data,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData &&
              snapshot.data == null) {
            return Card(
              child: ListTile(
                leading: Shimmer.fromColors(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                ),
                title: Shimmer.fromColors(
                  child: Container(
                    height: 5,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                ),
                subtitle: Shimmer.fromColors(
                  child: Container(
                    height: 5,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                ),
              ),
            );
          } else {
            if (snapshot.data?.docs.length == 0) {
              return Center(
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(
                        Config.thumbsDown,
                        height: 300,
                      ),
                      Text(
                        "User not found",
                        style: GoogleFonts.ubuntu(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container(
              height: 400,
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Object?>? data =
                      snapshot.data?.docs[index];
                  if (data != null && data.exists) {
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: data['avatar'] ??
                                "https://images.unsplash.com/photo-1624561172888-ac93c696e10c",
                            errorWidget: (context, url, err) {
                              return Image.asset(Config.error_image);
                            },
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          "${data['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          "Team : ${data['team'] ?? ''}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Icon(Ionicons.chevron_forward),
                      ),
                    );
                  }
                  return Card(
                    child: ListTile(
                      leading: Shimmer.fromColors(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                      ),
                      title: Shimmer.fromColors(
                        child: Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                      ),
                      subtitle: Shimmer.fromColors(
                        child: Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade200,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
