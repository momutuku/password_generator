import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:password_generator/modesl/password.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  List<Password> passwords = Password.getPasswords();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController siteURLController = TextEditingController();
  final TextEditingController siteUsernameController = TextEditingController();
  final TextEditingController sitePassController = TextEditingController();
  String? siteNameError;
  String? siteURLError;
  String? siteUsernameError;
  String? sitePassError;

  void _copyToClipboard(String textToCopy) {
    FlutterClipboard.copy(textToCopy).then((result) {
      FToast fToast = FToast();
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("🗝️🗝️ Password Copied"),
          ],
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  const CircleAvatar(
                    radius: 30,
                    foregroundImage:
                        NetworkImage("https://avatar.iran.liara.run/public/19"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: TextField(
                      onChanged: (searchParam) {
                        setState(() {
                          widget.passwords = Password.filterPassword(
                              Password.getPasswords(), (Password passsword) {
                            return passsword.pswName.contains(searchParam) ||
                                passsword.pswUser.contains(searchParam);
                          });
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search",
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.black54),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_outlined),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Column(
                    children: [
                      Column(
                        children: widget.passwords.map((password) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black45, width: 1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      _copyToClipboard(password.pswValue);
                                    },
                                    icon: const Icon(Icons.key),
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      password.pswName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(password.pswUser),
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Add A New Password",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: siteNameController,
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  labelText: "Name",
                                  prefixIcon: const Icon(
                                    color: Colors.grey,
                                    Iconsax.book,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: siteUsernameController,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  labelText: "Username",
                                  prefixIcon: const Icon(
                                      color: Colors.grey, Iconsax.user),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: siteURLController,
                              decoration: InputDecoration(
                                  hintText: "Website",
                                  labelText: "Website",
                                  prefixIcon: const Icon(
                                      color: Colors.grey, Iconsax.global),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: sitePassController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  labelText: "Password",
                                  prefixIcon: const Icon(
                                      color: Colors.grey,
                                      Iconsax.password_check),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.sync,
                                        color: Colors.grey),
                                    onPressed: () {},
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              height: 45,
                              color: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                "Add Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          backgroundColor: Colors.black54,
          child: const Icon(Icons.add),
        ));
  }
}

// Shimmer.fromColors(
//                 baseColor: Colors.grey.shade300,
//                 highlightColor: Colors.white,
//                 period: Duration(milliseconds: timer),
//                 child: box(),
//               );

Widget box() {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 150,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey),
              )
            ],
          ),
        )
      ],
    ),
  );
}
