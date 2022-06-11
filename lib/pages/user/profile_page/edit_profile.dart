// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:project/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

QuerySnapshot snapshot = await FirebaseFirestore.instance.collections("Users").get();

  for(var doc in snapshot.docs){
    log(doc.data().toString());
  } 
  runApp(EditProfile());
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Editprofile createState() => Editprofile();
}

class Editprofile extends State<EditProfile> {
  bool showPassword = true;
  var name = Users.studentName;
  var email = Users.studentEmail;
  var password = "";
  var phone = Users.studentPhone;
  var photourl = Users.studentphotourl;

  var address = "DTU, Delhi";


  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
            child: Expanded(
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: size,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWL6HWblTMbGEk_9c0lMxbCP_QWE8p_lXotg&usqp=CAU",
                        ))),
              ),
              Positioned(
                left: size / 3,
                top: h / 24,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 5))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            photourl,
                          ))),
                ),
              ),
              Positioned(
                  right: size / 3,
                  top: h / 5.5,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Color.fromARGB(255, 76, 165, 175),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          buildTextField("Full Name", name, false),
          buildTextField("E-mail", email, false),
          buildTextField("Password", password, true),
          buildTextField("Phone", phone, false),
          buildTextField("Address", address, false),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(14, 0, 0, 30),
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                  ),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 14, 30),
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    // await FirebaseAuth.instance.currentUser?.updateDisplayName("Jane Q. User");
                    // await FirebaseAuth.instance.currentUser?.updateEmail("janeq@example.com");
                    // await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                    // await FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneCredential);
                    // await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(newEmail);
                    //
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                  ),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextField(labelText, placeholder, isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0, left: 16, right: 16),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: showPassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 75, 75, 75),
            )),
      ),
    );
  }
}
