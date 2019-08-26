import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_ubru/screens/home.dart';
import 'package:golf_ubru/screens/list_product.dart';
import 'package:golf_ubru/screens/show_map.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  String loginString = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  double mySizeIcon = 36.0;
  double h2 = 18.0;
  Widget myWidget = ListProduct();

//Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      loginString = firebaseUser.displayName;
      print('login = $loginString');
    });
  }

  Widget listProductMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: mySizeIcon,
      ),
      title: Text(
        'List Products',
        style: TextStyle(fontSize: h2),
      ),
      subtitle: Text('Show List All of Product'),
      onTap: () {
        setState(() {
         myWidget = ListProduct(); 
         Navigator.of(context).pop();
        });
      },
    );
  }

  Widget mapMenu() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: mySizeIcon,
      ),
      title: Text(
        'Show Map',
        style: TextStyle(fontSize: h2),
      ),
      subtitle: Text('Show Current Location Map'),onTap: (){
        setState(() {
         myWidget = showMap(); 
         Navigator.of(context).pop();
        });
      },
    );
  }

  Widget signOutMenu() {
    return ListTile(
      leading: Icon(
        Icons.cached,
        size: mySizeIcon,
      ),
      title: Text(
        'Sign Out',
        style: TextStyle(fontSize: h2),
      ),
      onTap: () {
        processSignout();
      },
    );
  }

  Future<void> processSignout() async {
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget showLogin() {
    return Text(
      'Login by ... $loginString',
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget showAppName() {
    return Text(
      'Golf_UBRU',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.blue,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/road.jpg'), fit: BoxFit.fill),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget myDrewerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          myHeadDrawer(),
          listProductMenu(),
          mapMenu(),
          signOutMenu(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: myWidget,
      drawer: myDrewerMenu(),
    );
    return scaffold;
  }
}
