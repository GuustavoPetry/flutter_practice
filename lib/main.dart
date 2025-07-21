import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_widget.dart';

void main() {
  runApp(const AppWidget());

  /* 
    Riverpod - é um gerenciador de estado flexível e poderoso,
    desenvolvida por Remi Rousselet (criador do provider), e foi 
    criado para corrigir limitações do provider e oferecer uma abordagem
    mais robusta, segura e flexível.
    
    VANTAGENS:
      - seguro em tempo de compilação: detecta erros mais cedo
      - não depende de BuildContext
      - testável e modular
      - suporte nativo para Providers Assíncronos, como FutureProvider e
        StreamProvider

      - Para utilizar precisamos instalar o pacote => flutter_riverpod
    ____________________________________________________________________________

    BLoC - Business Logic Component
      - é um padrão de arquitetura que separa a lógica de negócios da interface
        de usuário utilizando Streams
      - ele foi criado pelo Google para facilitar o reuso da lógica em vários
        widgets

      VANTAGENS:
        - muito utilizado em aplicativos corporativos
        - força uma arquitetura bem definida
        - baseado em Streams

      Conceitos Principais:
        - Event: entrada enviada pelo usuário
        - State: saíde de bloco
        - Bloc: recebe eventos e emite estados

      - Para utilizar precisamos instalar o pacote => flutter_bloc
    ____________________________________________________________________________

      BLoC + Cubit
        - é uma versão mais simples e direta do Bloc, sem eventos, você apenas
        chama métodos e emite eventos diretamente
   */
}

