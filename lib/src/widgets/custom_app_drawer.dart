import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_menu.dart';
import 'package:utilidades/src/services/auth_service.dart';
import 'package:utilidades/src/views/login_view.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Colors.amber,
            height: 100,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsetsGeometry.only(top: 30, bottom: 10),
              child: Center(child: Image.asset("assets/images/utility.png")),
            ),
          ),
          ...appMenuItems.map(
            (item) => ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () {
                Navigator.pushReplacementNamed(context, item.route);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red,),
            title: Text("Sair", style: TextStyle(color: Colors.red),),
            onTap: () {
              AuthService.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false
              );
            },
          )
        ],
      ),
    );
  }
}
// 24665760