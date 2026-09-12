import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o aplicativo e passa o widget ContadorApp como o widget raiz da aplicação
}

class ContadorApp extends StatelessWidget {
  //essa classe é um widget sem estado, ou seja, não tem estado interno que possa mudar ao longo do tempo. Ela é usada para construir a interface do usuário
  const ContadorApp({super.key});
  //contrutor reapassando a key para o widget pai
  @override
  Widget build(BuildContext context) {
    //monta e devolve a config geral do app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',

      home: const TelaContador(),
    );
  }
}

class TelaContador extends StatefulWidget {
  //isso é novo, agr a tela precisa lembrar de coisas mas não guarda coisas sozinha
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  //essa é a classe que guarda as coisas de vdd, funciona como um cofre

  int _pecasAprovadas = 0;
  final _nomeController = TextEditingController();
  //é a ponte entre o que acontece na tela e nosso código dart, guarda o que é digitado

  final List<String> _registros = [];
  //lista vazia de textos, guarda o historico de inspeção

  void _aprovarPeca() {
    //função chamada toda vez que o botao "+1 peça" for apertado, uau

    setState(() {
      //sempre q um dado do state muda, tem q acontecer no setState tbm

      _pecasAprovadas += 1;
    });
  }

  void _registrarEZerar() {
    //função chamada quando o botao "registrar e zerar" for apertado

    final nome = _nomeController.text.trim().isEmpty
        ? 'Sem nome'
        : _nomeController.text.trim();
    //operador ternario (condiçao?valorVerdadeiro : valorFalso)
    //trim remove espaço em branco

    setState(() {
      //de novo, mudança = setState

      _registros.add('$nome - $_pecasAprovadas peça(s)');
      //print com variavel

      _pecasAprovadas = 0;
      //zera o contador pra o inspetor fazer o proximo lote
    });
  }

  @override
  void dispose() {
    //dispose é chamado pelo flutter quando a tela é removida da arvore (usuario sai da tela)

    _nomeController.dispose();
    //libera os recursos e evita deixar memoria alocada

    super.dispose();
    //chama a implementação original do dispose
    //tem que ser sempre a ultima linha
  }

  @override
  Widget build(BuildContext context) {
    //constroi a arvore de widgets que representa a tela atual

    return Scaffold(
      //esqueleto padrão de uma tela flutter
      appBar: AppBar(
        title: Text('Inspeção de Peças'),
        //titulo fixo
      ),

      body: Padding(
        //corpo da tela com espaçaento
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //coloca tudo em formato de coluna
          children: [
            TextField(
              //campo de texto onde o inspetor digita seu nome
              controller: _nomeController,

              //liga o campo de digitar ao declarado la em cima
              //pra conseguir ler o que foi escrito
              decoration: const InputDecoration(
                labelText: 'Nome do inspetor do turno',
                border: OutlineInputBorder(),
              ),

              onChanged: (texto) {
                //é chamado quando o usuario digita e apaga

                setState(() {});
                //chamamos um set vazio só pra fazer a tela atualizar
              },
            ),
            const SizedBox(height: 16),

            //um espaço entre um trem e outro
            Text(
              _nomeController.text.trim().isEmpty
                  ? 'Responsavel: Não informado'
                  : 'Responsavel: ${_nomeController.text.trim()}',

              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            Text(
              '$_pecasAprovadas',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),

            Row(
              //linha horizontal´
              mainAxisAlignment: MainAxisAlignment.center,

              //centraliza as coisas
              children: [
                FilledButton.icon(
                  //estilo de botao que ja vem preenchido
                  onPressed: _aprovarPeca,

                  icon: const Icon(Icons.add),
                  label: const Text('+1 peça'),
                ),
                const SizedBox(width: 12),

                OutlinedButton.icon(
                  //botão que é só o contorno
                  onPressed: _registrarEZerar,

                  icon: const Icon(Icons.save_alt),
                  label: const Text('Registrar e zerar'),
                ),
                const SizedBox(width: 16),
              ],
            ),
            
            const Align(
              //posiciona os filhos dentro do espaço disponivel
              alignment: Alignment.centerLeft,
              child: Text(
                'Historico de Turno',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: _registros.isEmpty
                  ? const Center(child: Text('Nenhum registro ainda'))
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),

                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
