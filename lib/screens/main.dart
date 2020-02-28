import 'package:flutter/material.dart';
import 'package:latihan_crud_api/core/models/profile_models.dart';
import 'package:latihan_crud_api/core/resources/api.dart';
import 'package:latihan_crud_api/core/widgets/list_widget.dart';
import 'package:latihan_crud_api/screens/form.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService;
  List<Profile> profile;

  @override
  void initState() { 
    super.initState();
    apiService = ApiService();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen()
            ) 
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getProfiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  profile = snapshot.data;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: ListView.builder(
                      itemCount: profile.length,
                      itemBuilder: (context, index) {
                        Profile profiles = snapshot.data[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: ListViewWidget(profile: profiles),
                        );
                      },
                    ),
                  );
                  break;
                default:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }
          },
        ),
      ),
    );
  }
}