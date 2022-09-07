import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> contacts = [
    {"Name": "Amos", "Phone": "07031250097"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MYSQLTODO"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                updateContact(context);
              },
              child: Card(
                elevation: 10,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(contacts[index]["Name"].substring(0, 1)),
                  ),
                  title: Text(contacts[index]["Name"].trim()),
                  subtitle: Text(contacts[index]["Phone"].trim()),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      contacts.removeAt(index);
                      setState(() {});
                    },
                  ),
                ),
              ),
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
    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Container(
        height: 200,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> userDetails = {};
                      userDetails["Name"] = name;
                      userDetails["Phone"] = phone;
                      // print(userDetails);
                      contacts.add(userDetails);
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

  updateContact(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? name, phone;
    AlertDialog update = AlertDialog(
      title: Text("Update Contact"),
      content: Container(
        height: 200,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Map<String, dynamic> userDetails = {};
                      userDetails["Name"] = name;
                      userDetails["Phone"] = phone;
                      // print(userDetails);
                      contacts.replaceRange;
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
