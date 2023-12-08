import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:joga_junto/src/login/controller.dart';

class NovaConta extends StatefulWidget {
  const NovaConta({Key? key}) : super(key: key);

  @override
  State<NovaConta> createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta> {
  final Controller controller = Controller();

  String nome = "";
  String cpf = "";
  String dataNasc = "";
  String tel = "";
  String email = "";
  String senha = "";
  String senhaConfirma = "";
  String? nomeErro;
  String? cpfErro;
  String? dataNascErro;
  String? emailErro;
  String? senhaErro;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (boxContext, box) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/telaPadrao');
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            const Center(
              child: Text(
                'Cadastro',
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
              txt: 'Nome Completo*',
              senha: false,
              date: false,
              erro: nomeErro,
              onChange: (String vl) {
                setState(() {
                  nome = vl;
                  nomeErro = null;
                });
              },
            ),
            _InputConta(
              txt: 'Data de nascimento*',
              senha: false,
              date: true,
              erro: dataNascErro,
              onChange: (String vl) {
                setState(() {
                  dataNasc = vl;
                  dataNascErro = null;
                });
              },
            ),
            _InputConta(
              txt: 'Telefone Celular',
              senha: false,
              date: false,
              erro: null,
              onChange: (String vl) {
                setState(() {
                  tel = vl;
                });
              },
            ),
/*             _InputConta(
              txt: 'CPF',
              senha: false,
              date: false,
              erro: cpfErro,
              onChange: (String vl) {
                setState(() {
                  cpf = vl;
                  cpfErro = null;
                });
              },
            ), */
            _InputConta(
              txt: 'Email*',
              senha: false,
              date: false,
              erro: emailErro,
              onChange: (String vl) {
                setState(() {
                  email = vl;
                  emailErro = null;
                });
              },
            ),
            _InputConta(
              txt: 'Senha*',
              senha: true,
              date: false,
              erro: senhaErro,
              onChange: (String vl) {
                setState(() {
                  senha = vl;
                  senhaErro = null;
                });
              },
            ),
            _InputConta(
              txt: 'Repita sua senha*',
              senha: true,
              date: false,
              erro: null,
              onChange: (String vl) {
                setState(() {
                  senhaConfirma = vl;
                  senhaErro = null;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (nome == "") {
                      setState(() {
                        nomeErro = 'Insira um nome válido';
                      });
                      return;
                    }
                    if (dataNasc == "") {
                      setState(() {
                        dataNascErro = 'Insira a data de nascimento';
                      });
                      return;
                    }
                    /* if (cpf == "") {
                      setState(() {
                        cpfErro = 'Insira um CPF válido';
                      });
                      return;
                    } */
                    if (email == "") {
                      setState(() {
                        emailErro = 'Insira um Email válido';
                      });
                      return;
                    }
                    if (senha == "") {
                      setState(() {
                        senhaErro = 'Insira uma senha válida';
                      });
                      return;
                    }
                    if (senha != senhaConfirma) {
                      setState(() {
                        senhaErro = 'As senhas não batem';
                      });
                      return;
                    }

                    controller
                        .criarConta(nome, cpf, dataNasc, tel, email, senha)
                        .then((s) {
                      if (s) {
                        Navigator.pushNamed(context, '/');
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
      {required this.txt,
      required this.senha,
      required this.onChange,
      required this.date,
      this.erro});

  final String txt;
  final bool senha;
  final bool date;
  final Function onChange;
  final String? erro;
  @override
  State<_InputConta> createState() => _InputContaState();
}

class _InputContaState extends State<_InputConta> {
  bool mostrar = false;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(80),
              ),
            ),
            hintText: widget.txt,
            errorText: widget.erro,
            suffix: widget.senha
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        mostrar = !mostrar;
                      });
                    },
                    child:
                        Icon(mostrar ? Icons.visibility : Icons.visibility_off),
                  )
                : const Icon(null),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          obscureText: !mostrar && widget.senha,
          onTap: () async {
            if (widget.date) {
              DateTime? vl = await showDatePicker(
                context: context,
                // initialEntryMode: DatePickerEntryMode.inputOnly,
                initialDate: DateTime.now(),
                firstDate: DateTime(1000),
                lastDate: DateTime(3000),
              );

              if (vl != null) {
                controller.text = DateFormat('dd/MM/y').format(vl);
                widget.onChange(DateFormat('dd/MM/y').format(vl));
              }
            }
          },
          onChanged: (vl) {
            widget.onChange(vl);
          },
          readOnly: widget.date,
        ),
      ),
    );
  }
}
