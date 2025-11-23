// Testes para o aplicativo FRANCINALDO PARA O MUNDO
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  testWidgets('App inicializa corretamente', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verifica se o título do app está presente
    expect(find.text('FRANCINALDO PARA O MUNDO'), findsWidgets);
    
    // Verifica se o banner está presente
    expect(find.text('Explore o Mundo com a Gente!'), findsOneWidget);
    
    // Verifica se o campo de pesquisa está presente
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Seção de botões está presente', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verifica se os botões de navegação estão presentes
    expect(find.text('DESTINOS'), findsOneWidget);
    expect(find.text('PACOTES'), findsOneWidget);
    expect(find.text('CONTATO'), findsOneWidget);
    expect(find.text('SOBRE'), findsOneWidget);
  });

  testWidgets('Destinos populares são exibidos', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verifica se a seção de destinos está presente
    expect(find.text('Destinos Populares'), findsOneWidget);
    
    // Verifica se pelo menos um destino está presente
    expect(find.text('Buenos Aires, Argentina'), findsOneWidget);
  });

  testWidgets('Navegação para detalhes do destino funciona', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Faz scroll até encontrar o card de destino
    final destinationText = find.text('Buenos Aires, Argentina');
    
    // Se não estiver visível, faz scroll
    await tester.scrollUntilVisible(destinationText, 500.0);
    await tester.pumpAndSettle();
    
    expect(destinationText, findsOneWidget);
    
    // Toca diretamente no texto do destino
    await tester.tap(destinationText);
    await tester.pump();
    await tester.pumpAndSettle();

    // Verifica se a página de detalhes foi aberta (verifica pelo título do destino)
    expect(find.text('Buenos Aires, Argentina'), findsWidgets);
    // Verifica se há um botão de reserva ou informações do destino
    expect(find.text('Reservar Agora'), findsOneWidget);
  });

  testWidgets('Campo de pesquisa funciona', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Encontra o campo de pesquisa
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Digita no campo de pesquisa
    await tester.enterText(searchField, 'Buenos Aires');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    // Verifica se o SnackBar foi exibido
    expect(find.text('Buscando por: Buenos Aires'), findsOneWidget);
  });
}
