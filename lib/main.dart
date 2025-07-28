import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Remote Config
  await FirebaseRemoteConfig.instance.setConfigSettings(
    RemoteConfigSettings(
      // Define o tempo máximo para execução da busca
      fetchTimeout: const Duration(minutes: 1),
      // Define o intervalo entre as tentativas de busca
      minimumFetchInterval: const Duration(minutes: 1),
    ),
  );
  await FirebaseRemoteConfig.instance.setDefaults(
    const {
      "saudacao": "Bem-Vindo",
      // Adicione quantos parâmetros desejar
    }
  );

  // Iniciar serviço background Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_backgoundMessaging);

  runApp(const AppWidget());

}

// Future para notificações background
Future<void> _backgoundMessaging(RemoteMessage message) async {}


  /* 
                  ***FERRAMENTAS ESSENCIAIS***

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

    ____________________________________________________________________________

    FIREBASE:
      - Firebase é uma plataforma da Google para desenvolvimento de aplicativos
        Web e Mobile, ela oferece um conjunto de serviços prontos que ajudam você
        a construir, melhorar e escalar aplicativos rapidamente, sem precisar criar
        tudo no Backend.

      * Principais Funcionalidades:
        - Autenticação -> login com e-mail/senha, google, facebook, apple, telefone...
        - Firestore -> banco de dados noSQL em tempo real, escalável e com sincronização
          automática
        - Realtime Database -> banco de dados noSQL com foco em dados em tempo real
        - Storage -> armazenamento de arquivos (imagens, vídeos, pdf e etc)
        - Hosting -> hospedagem rápida para sites estáticos como Flutter Web, React,
          Angular e etc
        - Functions -> funções servless com Node.js para lógica no Backend
        - Analytics -> monitoramente de uso, comportamento de usuário, eventos e etc
        - Crashlytics -> relatórios de erros em tempo real (crash reports)
        - Remote Configs -> personalização de comportamento do app remotamente
        - Cloud Messaging (FCM) -> envio de notificações push para android, ios e web

        * O Firebase tem um plano gratuito para pequenos projetos que é bem generoso
          e um plano pago para projetos grandes e escaláveis.

        * Documentação para implementação:
          - https://firebase.google.com/docs/flutter/setup?hl=pt-br&platform=ios

          1. instalar a CLI do Firebase via npm (no cmd /users):
            - npm install -g firebase-tools
          
          2. fazer login na CLI com conta Google via cmd:
            - firebase login

          3. instale a CLI do FlutterFire via cmd:
            - dart pub global activate flutterfire_cli
          
          4. configurar a CLI no terminal do projeto flutter:
            - flutterfire configure
            (isso cria o arquivo "firebase_options.dart")

          5. instalar dependência firebase_core no projeto:
            - flutter pub add firebase_core

          6. para garantir que a configuração esteja atualizada rode novamente:
            - flutterfire configure
            (sempre que clonar um projeto que utiliza firebase rodar esse comando)

          7. acessar o arquivo do projeto => android\app\build.gradle.kts:
            - alterar o valor de compileSdk para => compileSdk = 34
            - alterar o valor de ndkVersion para => ndkVersion = "27.0.12077973"
            - alterar o valor de minSdk para => minSdk = 23
            - alterar o valor de targetSdk para => targetSdk = 34
            - criar uma nova linha dentro de defaultConfig e inserir => multiDexEnabled = true
          
          8. Em main.dart, importe o plug-in principal e o arquivo de configuração gerado antes:
            - import 'package:firebase_core/firebase_core.dart';
            - import 'firebase_options.dart';

          9. Em main.dart, inicialize o Firebase usando "DefaultFirebaseOptions" do arquivo de configuração:
            WidgetsFlutterBinding.ensureInitialized();
            await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            );
            runApp(const MyApp());

            *OBS: transformar o método main em async:
              - void main() async {}

          10. Atualize a o console do Firebase na Web, deverá conter o seu projeto configurado

          11. Configurações de segurança, para não commitar dados sensíveis de acesso ao Firebase:
            - inserir no .gitignore
              #Firebase
              android/app/google-services.json
              ios/firebase_app_id_file.json
              ios/Runner/GoogleServices-Info.plist
              lib/firebase_options.dart 

              (se for utilizar no projeto criar uma conta firebase para compartilhar com todos integrantes)

          12. Rodar o projeto com "flutter run" para recriar o projeto

          13. No console da Web acessar "Authentication", e clicar em "vamos começar":
                - ativar a opção "Email/Senha" e salvar

            - Criar banco de dados em => Firestone Database e escolher servidor de São Paulo

            - Optar por Modo de Teste ou Mode de Produção a depender do caso e clicar em "criar"

          14. Adicionar dependência de autenticação no projeto
            - flutter pub add firebase_auth

          15. Adicionar dependência do Cloud Firestone no projeto
            - flutter pub add cloud_firestore

   */
