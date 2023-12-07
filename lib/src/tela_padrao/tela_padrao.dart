import 'package:joga_junto/default/default_values.dart';
import 'package:flutter/material.dart';

class TelaPadrao extends StatefulWidget {
  const TelaPadrao({Key? key, this.isPageView}) : super(key: key);

  final bool? isPageView;

  @override
  State<TelaPadrao> createState() => _TelaPadraoState();
}

class _TelaPadraoState extends State<TelaPadrao> {
  @override
  Widget build(BuildContext context) {
    if (widget.isPageView ?? true) return const _tela();
    return const Scaffold(
      body: _tela(),
    );
  }
}

class _tela extends StatelessWidget {
  const _tela({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return ColoredBox(
        color: mainCor,
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Center(),
            ),
            SizedBox(
              width: box.maxWidth,
              height: (box.maxHeight * 35) / 100,
              child: Image.asset(
                'assets/icone_app.png', // img
                // width: (box.maxWidth * 85) / 100,
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Joinville Joga Junto',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFFD9DEEE),
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Seja bem vindo!',
                  style: TextStyle(
                    fontSize: 19,
                    height: 1.3,
                    color: Color(0XFFD9DEEE),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login/novaConta');
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0XFFFFFFFF),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  fixedSize: MaterialStatePropertyAll(
                    Size(
                      (box.maxWidth * 55) / 100,
                      (box.maxWidth * 12) / 100,
                    ),
                  ),
                ),
                child: const Text(
                  'Criar nova conta',
                  style: TextStyle(color: Color(0XFF000000)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0XFFFFFFFF),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  fixedSize: MaterialStatePropertyAll(
                    Size(
                      (box.maxWidth * 30) / 100,
                      (box.maxWidth * 12) / 100,
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Color(0XFF000000)),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
