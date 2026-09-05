import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
  //liga o aplicativo e passa o widget ContadorApp como o widget raiz da aplicação
}
class ContadorApp extends StatelessWidget{
  //essa classe é um widget sem estado, ou seja, não tem estado interno que possa mudar ao longo do tempo. Ela é usada para construir a interface do usuário
  const ContadorApp({super.key});
  //contrutor reapassando a key para o widget pai
  @override
  Widget build(BuildContext context){
    //monta e devolve a config geral do app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',

      home: const TelaContador(),
    );
  }
}
class TelaContador extends StatefulWidget{
  //isso é novo, agr a tela precisa lembrar de coisas mas não guarda coisas sozinha
  const TelaContador({super.key})

  @override
  State<TelaContador> createState() => _TelaContadorState();
  
  class _TelaContadorState extends State<TelaContador>{
    //essa é a classe que guarda as coisas de vdd, funciona como um cofre

    int _pecasAprovadas = 0;
    final _nomeController = TextEditingController();
    //é a ponte entre o que acontece na tela e nosso código dart, guarda o que é digitado
  }
}