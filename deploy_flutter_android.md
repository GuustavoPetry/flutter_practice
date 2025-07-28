
# Guia de Deploy Flutter Android

Este guia descreve os passos para configurar ícones, assinar o aplicativo e gerar o APK em modo release.

---

## 1. Inserir ícones iniciadores (launcher icons)

1. Acesse o site [appicon.co](https://appicon.co) e gere os ícones a partir da imagem desejada.

2. Extraia as pastas geradas e copie para:
    ```
    android/app/src/main/res
    ```

3. Se alterar o nome das imagens, atualize as referências em:
    ```
    android/app/src/main/AndroidManifest.xml
    ```

4. Após isso, o app mostrará o novo ícone na inicialização.

> **Dica:** Use o pacote `flutter_launcher_icons` para facilitar:
    ```bash
    flutter pub add flutter_launcher_icons
    ```

---

## 2. Criar a assinatura do app

5. Verifique se o `keytool` está disponível:
    ```bash
    where keytool
    ```
Se não estiver, adicione o caminho do JDK no `PATH`:
    ```
    C:\Program Files\Java\jdk-XX.X.X\bin
    ```

6. Gere o keystore executando (PowerShell):
    ```powershell
    keytool -genkey -v -keystore "$env:USERPROFILE\upload-keystore.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```

7. Preencha as informações solicitadas e defina uma senha segura.  
O arquivo será salvo em:
    ```
    C:\Users\ogust\upload-keystore.jks
    ```

8. Copie o arquivo para:
    ```
    android/app/
    ```

---

## 3. Referenciar o keystore no projeto

9. Crie o arquivo `key.properties` em:
    ```
    android/
    ```
Com o conteúdo:

    ```properties
    storePassword=<senha_do_keystore>
    keyPassword=<senha_da_chave>
    keyAlias=upload
    storeFile=<upload-keystore.jks>
    ```

> **Importante:** Inclua `key.properties` no `.gitignore` para evitar versionamento.

---

## 4. Configurar o `build.gradle.kts`

10. No arquivo `android/app/build.gradle.kts`, adicione:

    ```kotlin
    import java.util.Properties
    import java.io.FileInputStream

    val keystoreProperties = Properties()
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        FileInputStream(keystorePropertiesFile).use { fis ->
            keystoreProperties.load(fis)
        }
    }
    ```

Dentro do bloco `signingConfigs`:

    ```kotlin
    signingConfigs {
        create("release") {
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
        }
    }
    ```

Confirme que a configuração de build release está usando essa assinatura:

    ```kotlin
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            // outras configurações...
        }
    }
    ```

---

## 5. Gerar o APK assinado

11. Limpe o projeto:
    ```bash
    flutter clean
    ```

12. Gere o APK em modo release:
    ```bash
    flutter build apk --release
    ```

O APK gerado estará em:
    ```
    build/app/outputs/flutter-apk/app-release.apk
    ```

---

## 6. Criar Conta de Desenvolvedor

13. Crie pelo site => (https://play.google.com/console)

---

## 7. Publicar o App na PlayStore Corretamente

14. Siga a documentação => (https://www.queroapp.com.br/artigo/como-publicar-seu-aplicativo-android-na-play-store)

---

## Dicas finais 

- Para publicar na Play Store, gere o App Bundle:
    ```bash
    flutter build appbundle --release
    ```

- Proteja suas senhas e arquivos `key.properties` e `keystore` para não expor dados sensíveis.

---
