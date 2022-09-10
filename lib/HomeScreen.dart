import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mysqltodo/DBHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> contacts = [
    {"name": "Amos", "phone": "07031250097"},
  ];

  getContact() {
    DbHelper dbHelper = DbHelper();
    return dbHelper.selectContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MYSQLTODO"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: FutureBuilder(
          future: getContact(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: Text("No Data"));
            }
            List contacts = snapshot.data as List;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    updateContact(context, contacts[index]);
                  },
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(contacts[index]["name"].substring(0, 1)),
                      ),
                      title: Text(contacts[index]["name"].trim()),
                      subtitle: Text(contacts[index]["phone"].trim()),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () async {
                          DbHelper dbHelper = DbHelper();
                          int result = await dbHelper.delete(contacts[index]);
                          if (result > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Success")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("No Data")));
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addContact(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  addContact(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? name, phone;
    DbHelper dbHelper = DbHelper();
    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Container(
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text("Name"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[700],
                ),
                validator: (value) {
                  if (value!.length < 4) {
                    return "Name too Short";
                  }
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Phone"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[700],
                ),
                validator: (value) {
                  if (value!.length < 11) {
                    return "Number must be greater than eleven";
                  }
                },
                onSaved: (value) {
                  phone = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> userDetails = {};
                      userDetails["name"] = name;
                      userDetails["phone"] = phone;
                      int result = await dbHelper.saveContact(userDetails);
                      if (result > 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Success")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("No Data")));
                      }
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  elevation: 10,
                  shape: StadiumBorder(),
                  child: Text("SUBMIT"),
                  color: Colors.red,
                  textColor: Colors.grey),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  updateContact(BuildContext context, Map contact) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? name, phone;
    var nameCTRL = TextEditingController();
    var phoneCTRL = TextEditingController();
    nameCTRL.text = contact["name"];
    phoneCTRL.text = contact["phone"];
    AlertDialog update = AlertDialog(
      title: Text("Update Contact"),
      content: Container(
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCTRL,
                decoration: InputDecoration(
                  label: Text("Name"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[700],
                ),
                validator: (newValue) {
                  if (newValue!.length < 4) {
                    return "Name too Short";
                  }
                },
                onSaved: (newValue) {
                  name = newValue;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneCTRL,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Phone"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  filled: true,
                  fillColor: Colors.grey[700],
                ),
                validator: (newValue) {
                  if (newValue!.length < 11) {
                    return "Number must be greater than eleven";
                  }
                },
                onSaved: (newValue) {
                  phone = newValue;
                },
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> userDetails = {};
                      userDetails["name"] = name;
                      userDetails["phone"] = phone;
                      DbHelper dbHelper = DbHelper();
                      int result = await dbHelper.update(userDetails);
                      if (result > 0) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Success")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("No Data")));
                      }
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  elevation: 10,
                  shape: StadiumBorder(),
                  child: Text("UPDATE"),
                  color: Colors.red,
                  textColor: Colors.grey),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return update;
        });
  }
}
