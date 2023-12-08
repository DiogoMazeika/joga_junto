import 'package:flutter/material.dart';
import 'package:joga_junto/src/login/controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Controller controller = Controller();
  String email = "";
  String senha = "";
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/main');
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            const Center(
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Digite seu email e sua senha e\n comece a praticar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF606060),
                  ),
                ),
              ),
            ),
            _InputConta(
              txt: 'Email',
              senha: false,
              onChange: (String vl) {
                setState(() {
                  email = vl;
                });
              },
            ),
            _InputConta(
              txt: 'Senha',
              senha: true,
              onChange: (String vl) {
                setState(() {
                  senha = vl;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.entrar(email, senha).then((login) {
                      if ('${login['ok']}' == 'true') {
                        Navigator.pushNamed(context, '/main');
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: const Text('Email ou senha errados!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                      Size(box.maxWidth - 44, 44),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  child: const Text('Registrar'),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class _InputConta extends StatefulWidget {
  const _InputConta(
      {required this.txt, required this.senha, required this.onChange});

  final String txt;
  final bool senha;
  final Function onChange;
  @override
  State<_InputConta> createState() => _InputContaState();
}

class _InputContaState extends State<_InputConta> {
  bool mostrar = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
              ),
              hintText: widget.txt,
              suffix: widget.senha
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          mostrar = !mostrar;
                        });
                      },
                      child: Icon(
                          mostrar ? Icons.visibility_off : Icons.visibility),
                    )
                  : const Icon(null),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
          obscureText: mostrar,
          onChanged: (vl) {
            widget.onChange(vl);
          },
        ),
      ),
    );
  }
}
