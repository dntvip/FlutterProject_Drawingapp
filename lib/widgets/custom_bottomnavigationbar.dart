import 'package:flutter/material.dart';
import 'package:version2/pages/work_screen.dart';
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 110,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFF7165D6),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20),

            child: const Center(
              child: Text(
                "Let's Draw!",
                style: TextStyle(
                  fontFamily: 'JacquardaBastarda9-Regular',
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return
                  Container(
                    color: const Color(0xFF7165D6),
                    child: Wrap(
                      children: [
                        ListTile(
                          title: const Text('Small', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('16x16', style: TextStyle(color: Colors.white54)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkScreen(height: 16, width: 16),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Medium', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('32x32', style: TextStyle(color: Colors.white54)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkScreen(height: 32, width: 32),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Large', style: TextStyle(color: Colors.white)),
                          subtitle: const Text('64x64', style: TextStyle(color: Colors.white54)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkScreen(height: 64, width: 64),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Custom', style: TextStyle(color: Colors.white)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController heightController = TextEditingController();
                                TextEditingController widthController = TextEditingController();

                                return AlertDialog(
                                  title: const Text('Enter Grid Size'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: heightController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(hintText: "Enter height"),
                                      ),
                                      TextField(
                                        controller: widthController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(hintText: "Enter width"),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        int? height = int.tryParse(heightController.text);
                                        int? width = int.tryParse(widthController.text);

                                        if (height != null && width != null) {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WorkScreen(height: height, width: width),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('OK'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                      ],
                    ),

                  );
              },
            );
          },

        ),
      ),
    );
  }
}
