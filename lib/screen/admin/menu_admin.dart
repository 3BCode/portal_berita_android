import 'package:flutter/material.dart';
import 'package:portal_berita/screen/admin/home_admin.dart';
import 'package:portal_berita/screen/admin/profil_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuAdmin extends StatefulWidget {
  final VoidCallback signOut;
  const MenuAdmin(this.signOut, {super.key});

  @override
  State<MenuAdmin> createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  int selectIndex = 0;
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String userid = "", email = "";

  late TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userid = preferences.getString("id")!;
      email = preferences.getString("email")!;
    });
    print(userid);
  }

  Future<void> onRefresh() async {
    getPref();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Offstage(
              offstage: selectIndex != 0,
              child: TickerMode(
                enabled: selectIndex == 0,
                child: const HomeAdmin(),
              ),
            ),
            Offstage(
              offstage: selectIndex != 1,
              child: const ProfilAdmin(),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: 60,
          height: 60,
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectIndex = 0;
                    });
                  },
                  child: Tab(
                    icon: Icon(
                      Icons.home,
                      size: 30.0,
                      color: selectIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                    child: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: selectIndex == 0 ? Colors.blue : Colors.grey),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectIndex = 1;
                    });
                  },
                  child: Tab(
                    icon: Icon(
                      Icons.account_circle,
                      size: 30.0,
                      color: selectIndex == 1 ? Colors.blue : Colors.grey,
                    ),
                    child: Text(
                      'Profil',
                      style: TextStyle(
                          fontSize: 10.0,
                          color: selectIndex == 1 ? Colors.blue : Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
