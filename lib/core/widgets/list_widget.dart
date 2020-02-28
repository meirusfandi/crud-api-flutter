import 'package:flutter/material.dart';
import 'package:latihan_crud_api/core/models/profile_models.dart';
import 'package:latihan_crud_api/core/resources/api.dart';
import 'package:latihan_crud_api/screens/form.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ListViewWidget extends StatefulWidget {
  
  Profile profile;
  ListViewWidget({Key key, this.profile}) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {

  ApiService apiService;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.profile.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.profile.email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.profile.age.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => FormScreen(profile: widget.profile)
                        )
                      );
                    }, 
                    hoverColor: Colors.blue,
                    child: Text('Edit')
                  ),
                  FlatButton(
                    onPressed: () {
                      apiService.deleteProfile(widget.profile.id).then((isSuccess) {
                        if (!isSuccess) {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Delete data failed"),
                          ));
                        }
                      });
                    }, 
                    hoverColor: Colors.blue,
                    child: Text('Delete')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}