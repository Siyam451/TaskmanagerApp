
import 'package:flutter/material.dart';
import 'package:taskmanagement/Data/auth_controller.dart';
import 'package:taskmanagement/UI/screens/login_Screen.dart';
import '../update_profile_screen.dart';

class Tmappbar extends StatefulWidget implements PreferredSizeWidget {
  const Tmappbar({super.key, this.fromupdatescreen});

  final bool? fromupdatescreen;

  @override
  State<Tmappbar> createState() => _TmappbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TmappbarState extends State<Tmappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.fromupdatescreen ?? false) {
                return; // return if opened from update screen
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen(),
                ),
              );
            },
            child: const CircleAvatar(),
          ),
          const SizedBox(width: 8), // spacing instead of Row.spacing
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userModel?.fullname ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                AuthController.userModel?.email ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: _signOut,
        )
      ],
    );
  }

  Future<void> _signOut() async {
    //await use kora hoise karon future type er operation
    await AuthController.clearUserData(); //signout er por data clear korbe
     Navigator.pushReplacementNamed(context, LoginScreen.name);

  }
}
