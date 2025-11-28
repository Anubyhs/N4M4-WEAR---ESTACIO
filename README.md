# N4M4 Wear OS - Estácio

Aplicativo Wear OS desenvolvido para assistir funcionários com necessidades especiais, melhorando a eficiência, comunicação interna e solidificando a interação entre eles.

## ⌚ Sobre o App

O **N4M4 Wear OS** é um aplicativo para dispositivos Wear OS que oferece:

### Funcionalidades Implementadas:
- ✅ **Detecção de dispositivos de áudio** (alto-falante integrado e Bluetooth)
- ✅ **Detecção dinâmica de dispositivos de áudio** (callbacks para mudanças)
- ✅ **Reprodução de áudio** (mensagens, notificações, alertas)
- ✅ **Abertura de configurações do Bluetooth** para facilitar conexão
- ✅ **Interface com imagem de João Pessoa como papel de parede**

### Casos de Uso:
- **Informações baseadas em áudio:** Leitura de mensagens de texto, notificações, lembretes e resposta a comandos de voz (especialmente útil para pessoas com deficiência visual)
- **Treinamento e educação:** Fornece instruções, dicas e feedback durante o aprendizado ou prática de novas habilidades
- **Alertas de segurança:** Usa áudio para fornecer alertas de segurança, incluindo notificações de emergência, alertas de tempestade, notícias importantes ou informações críticas

## 🚀 Como Executar

### Pré-requisitos
- Android Studio instalado
- Android SDK configurado
- Emulador Wear OS 2 configurado

### Instalação e Execução

1. Clone o repositório:
```bash
git clone https://github.com/Anubyhs/N4M4-WEAR---ESTACIO.git
cd N4M4-WEAR---ESTACIO
```

2. Abra o projeto no Android Studio:
```bash
cd android
# Abra o projeto no Android Studio
```

3. Inicie o emulador Wear OS 2:
```bash
flutter emulators --launch Wear_2
# Ou através do Android Studio: Tools > Device Manager > Wear_2 > Play
```

4. Compile e instale o app:
```bash
./gradlew :wear:installDebug
```

5. Execute o app:
```bash
adb shell am start -n com.example.wearosapp/.MainActivity
```

## 📦 Estrutura do Projeto

```
android/
  └── wear/              # Módulo Wear OS
      ├── build.gradle.kts
      └── src/main/
          ├── java/      # Código Java do app Wear
          │   └── com/example/wearosapp/
          │       ├── MainActivity.java
          │       └── AudioHelper.java
          └── res/        # Recursos (layouts, imagens, etc.)
              ├── drawable/
              ├── layout/
              └── values/
```

## 🛠️ Tecnologias Utilizadas

- **Android SDK** - Desenvolvimento Android nativo
- **Java** - Linguagem de programação
- **Wear OS** - Plataforma para dispositivos vestíveis
- **AudioManager** - Gerenciamento de dispositivos de áudio
- **MediaPlayer** - Reprodução de áudio

## 📝 Funcionalidades Técnicas

### AudioHelper
Classe utilitária para gerenciamento de dispositivos de áudio:
- Detecção de alto-falante integrado
- Detecção de fones Bluetooth conectados
- Callbacks para mudanças dinâmicas de dispositivos
- Abertura de configurações do Bluetooth

### MainActivity
Activity principal do app com:
- Interface com imagem de João Pessoa como papel de parede
- Botões para explorar, reproduzir áudio e conectar Bluetooth
- Status em tempo real dos dispositivos de áudio
- Reprodução de áudio com MediaPlayer

## 👨‍💻 Desenvolvido por

**FRANCINALDO** - Estácio N4M4

Desenvolvido com ❤️ para melhorar a acessibilidade e inclusão no ambiente de trabalho!
