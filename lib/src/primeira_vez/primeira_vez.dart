import 'package:flutter/material.dart';

class PrimeiraVez extends StatelessWidget {
  const PrimeiraVez({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageViewExample(),
    );
  }
}

class PageViewExample extends StatelessWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return LayoutBuilder(builder: (context, box) {
      return PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: [
          Center(
            child: pagina(
                'Joinville Joga Junto',
                'O Aplicativo Joinville Joga Junto veio a\n partir da necessidade de amantes do\n esporte acharem pessoas com afinco ou\n sem, e locais para praticar seus esportes\n favoritos.',
                box,
                0XFFFFB647,
                0XFFFFF0DA),
          ),
          Center(
            child: pagina(
                'Como funciona?',
                'Você pode procurar locais e grupos que\n desejam praticar esportes em horários\n que você desejar! Basta apertar no\n local que quer marcar ou participare\n esperar a hora chegar.',
                box,
                0XFFff6767,
                0XFFFFE1E1),
          ),
          Center(
            child: pagina(
                'Preciso pagar algo?',
                'O aplicativo Joinville Joga Junto é\n focado para ser totalmente gratuito, a\n unica forma de pagamento que existe é\n pensado caso as quadras em que\n ocorrerão os jogos sejam pagas ou caso\n seja necessario levar equipamentos\n próprios.',
                box,
                0XFF47C664,
                0XFFDAF4E0),
          ),
        ],
      );
    });
  }

  Widget pagina(
      String ttl, String txt, BoxConstraints box, int cor, int corSecundaria) {
    return SizedBox(
      width: box.maxWidth,
      height: box.maxHeight,
      child: ColoredBox(
        color: Color(cor),
        child: Column(
          children: [
            Image.asset(
              'assets/warning.png', // img
              width: (box.maxWidth * 45) / 100,
            ),
            Expanded(
              child: Center(
                child: Text(
                  ttl,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(corSecundaria),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  txt,
                  style: TextStyle(
                    fontSize: 19,
                    height: 1.3,
                    color: Color(corSecundaria),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                child: SizedBox(
                  width: (box.maxWidth * 20) / 100,
                  height: (box.maxWidth * 20) / 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Color(corSecundaria),
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      size: 33,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
