import 'package:flutter/material.dart';
import 'package:joga_junto/src/tela_padrao/tela_padrao.dart';

class PrimeiraVez extends StatelessWidget {
  const PrimeiraVez({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Apresentacao(),
    );
  }
}

class _Apresentacao extends StatefulWidget {
  const _Apresentacao({super.key});

  @override
  State<_Apresentacao> createState() => _ApresentacaoState();
}

class _ApresentacaoState extends State<_Apresentacao> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return PageView(
        controller: controller,
        children: [
          pagina(
            'Joinville Joga Junto',
            'O Aplicativo Joinville Joga Junto veio a\n partir da necessidade de amantes do\n esporte acharem pessoas com afinco ou\n sem, e locais para praticar seus esportes\n favoritos.',
            box,
            0XFFFFB647,
            0XFFFFF0DA,
            0XFFFFDBA3,
            0,
            controller,
          ),
          pagina(
            'Como funciona?',
            'Você pode procurar locais e grupos que\n desejam praticar esportes em horários\n que você desejar! Basta apertar no\n local que quer marcar ou participar\n e esperar a hora chegar.',
            box,
            0XFFff6767,
            0XFFFFE1E1,
            0XFFFFB3B3,
            1,
            controller,
          ),
          pagina(
            'Preciso pagar algo?',
            'O aplicativo Joinville Joga Junto é\n focado para ser totalmente gratuito, a\n unica forma de pagamento que existe é\n pensado caso as quadras em que\n ocorrerão os jogos sejam pagas ou caso\n seja necessario levar equipamentos\n próprios.',
            box,
            0XFF47C664,
            0XFFDAF4E0,
            0XFFA3E3B2,
            2,
            controller,
          ),
          const TelaPadrao(),
        ],
      );
    });
  }

  Widget pagina(
    String ttl,
    String txt,
    BoxConstraints box,
    int cor,
    int corSecundaria,
    int corTerciaria,
    int p,
    PageController controller,
  ) {
    return ColoredBox(
      color: Color(cor),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.jumpToPage(3);
                    },
                    child: Text(
                      'Pular',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(corSecundaria),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: box.maxWidth,
            height: (box.maxHeight * 35) / 100,
            child: Image.asset(
              'assets/img_primeira_vez_$p.png', // img
              // width: (box.maxWidth * 85) / 100,
            ),
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
              onTap: () {
                controller.jumpToPage(p + 1);
              },
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
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: p == 0
                            ? const Color(0XFFFFFFFF)
                            : Color(corTerciaria),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: p == 1
                            ? const Color(0XFFFFFFFF)
                            : Color(corTerciaria),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 10,
                    height: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: p == 2
                            ? const Color(0XFFFFFFFF)
                            : Color(corTerciaria),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
