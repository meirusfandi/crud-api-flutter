import 'package:flutter/material.dart';
import 'package:latihan_crud_api/core/models/profile_models.dart';
import 'package:latihan_crud_api/core/resources/api.dart';
import 'package:latihan_crud_api/screens/main.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormScreen extends StatefulWidget {
  
  Profile profile;

  FormScreen({Key key, this.profile}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  ApiService apiService;
  @override
  void initState() { 
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    
    TextEditingController nameController = TextEditingController(text: widget.profile != null ? widget.profile.name : '');
    TextEditingController ageController = TextEditingController(text: widget.profile != null ? widget.profile.age.toString() : '0');
    TextEditingController emailController = TextEditingController(text: widget.profile != null ? widget.profile.email : '');
    return Scaffold(
      appBar: AppBar(
        title: widget.profile == null ? Text('Tambah User') : Text('Update User')
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap mengisi nama';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                style: TextStyle( color: Colors.black),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue)
                  ),
                  border:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.red)
                  ),
                  labelText: 'Input Name',
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap mengisi email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle( color: Colors.black),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue)
                  ),
                  border:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.red)
                  ),
                  labelText: 'Input Email',
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                controller: ageController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Harap mengisi Umur';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                style: TextStyle( color: Colors.black),
                decoration:  InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue)
                  ),
                  border:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.red)
                  ),
                  labelText: 'Input Umur',
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: const Icon(
                    Icons.date_range,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      String name = nameController.text.toString();
                      String email = emailController.text.toString();
                      int age = int.parse(ageController.text.toString());

                      Profile data = Profile(name: name, email: email, age: age);
                      if (widget.profile != null) {
                        data.id = widget.profile.id;
                        apiService.updateProfile(data).then((isSuccess) {
                          if (isSuccess) {
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      } else {
                        apiService.createProfile(data).then((isSuccess) {
                          if (isSuccess) {
                            Navigator.pop(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      }
                    });
                  },
                  color: Colors.amber,
                  child: Text(
                    widget.profile != null ? 'Update' : 'Save',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.amber,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}