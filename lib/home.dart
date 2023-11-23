import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        return Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 70,
              child: Material(
                color: Color(0xff494747),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'D&D',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xffffffff)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: box.maxHeight - 140,
              child: Material(
                color: const Color(0xffefefef),
                child: Center(
                  child: ListView(
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text('texto'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 70,
              child: Material(
                color: Color(0xff494747),
              ),
            ),
          ],
        );
      },
    );
  }
}
