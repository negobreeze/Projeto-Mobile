import 'package:flutter/material.dart';//importe normal
// App que irá acompanhar o preço do bitcoin
import 'package:http/http.dart' as http;//importa no pubspec http: ^0.13.5
import 'dart:async';//import para pegar a informação assincrona do servidor.
import 'dart:convert';//importe para converter a api em json.

  void main(){
   runApp(MaterialApp(
    title: 'App Preço do bitcoin',
    home: _bitcoin(),
  ));
}

String get newMethod => 'App Preço bitcoin';

//criado um stateful class com o nome de _bitcoin
class _bitcoin extends StatefulWidget {
  const _bitcoin({Key? key}) : super (key: key);

  @override
  State<_bitcoin> createState() => _bitcoinState();
}
//criado um stateful class com o nome de _bitcoin
class _bitcoinState extends State<_bitcoin> {
  //Pré back do app

  String _preco = '0';//string do preço do bitcoin, um pré para exibir em uma text
  void _recuperarPreco()async{//uma pré  função para exibir no onpress do botão atualizar
    String _url = 'https://blockchain.info/ticker';
    http.Response response = await http.get(Uri.parse(_url));
    Map<String,dynamic> retorno = jsonDecode(response.body);
    setState(() {
      _preco=retorno['BRL']['buy'].toString();
    });

    print('Resultado:' + retorno['BRL']['buy'].toString(response.body));
  }
//fIM do back
  @override
  Widget build(BuildContext context) {
    //começo do front do app
    return Scaffold(
      backgroundColor: Colors.orange,//cor de fundo do body com o tema do app
      body: Container(
        padding: EdgeInsets.all(32),//espaçamento
        child: Center(//centralizar os elementos
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,//centralizar a coluna
            crossAxisAlignment: CrossAxisAlignment.stretch,//preencher a coluna
            children: <Widget>[
              Image.asset('imagens/Bitcoin.png'),//imagem da logo do app
              Padding(padding: EdgeInsets.only(top: 30, bottom: 30),//espaçamento cima e baixa
              child: Text(
                'R\$'+_preco,//desta forma exibi o $ do preço em reais. moeda brasileira
                style: TextStyle(fontSize: 35),//tamanho da fonte
              ),
              ),
              ElevatedButton(//botão para atualizar o preço
                onPressed: _recuperarPreco, //pré função para atualizar o preço
                // ignore: sort_child_properties_last
                child: Text(
              'Atualizar', //nome do botão
              style: TextStyle(fontSize:20, color: Colors.white60),
                ),
              style: ElevatedButton.styleFrom( //estilizar o botão
                backgroundColor: Colors.deepOrange, //cr do botão
                padding: EdgeInsets.fromLTRB(15,15,15,15), //padrão de tamanho no sentido =>esquerda,cima,direita,esquerda
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
