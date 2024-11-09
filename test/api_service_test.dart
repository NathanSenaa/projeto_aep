import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_aep/services/api_service.dart';

void main() {
  final ApiService apiService = ApiService();

  group('Teste de Verificação de Links', () {
    
    test('Link válido com http://', () async {
      String result = await apiService.analyzeLink('http://google.com');
      expect(result, 'Esse link parece seguro.');
    });

    test('Link válido com https://', () async {
      String result = await apiService.analyzeLink('https://google.com');
      expect(result, 'Esse link parece seguro.');
    });

    test('Link inválido sem http:// ou https://', () async {
      String result = await apiService.analyzeLink('google.com');
      expect(result, 'Link inválido: o link deve começar com http:// ou https:// para ser considerado seguro.');
    });

    test('Link inválido com formato incorreto', () async {
      String result = await apiService.analyzeLink('htp://google.com');
      expect(result, 'Link inválido: formato do link inválido. Certifique-se de que o link esteja correto.');
    });

    test('Link com palavra-chave suspeita', () async {
      String result = await apiService.analyzeLink('http://freeoffer.com');
      expect(result, 'Cuidado! Esse link pode ser suspeito. Ele contém palavras-chave associadas a phishing.');
    });

    test('Link com muitos caracteres especiais', () async {
      String result = await apiService.analyzeLink('http://example!@#\$.com');
      expect(result, 'Cuidado! Esse link contém muitos caracteres incomuns e pode ser suspeito.');
    });

    test('Link seguro, sem palavras-chave suspeitas', () async {
      String result = await apiService.analyzeLink('https://example.com');
      expect(result, 'Esse link parece seguro.');
    });

    test('Link com formato suspeito e protocolo http', () async {
      String result = await apiService.analyzeLink('http://example!free.com');
      expect(result, 'Cuidado! Esse link pode ser suspeito. Ele contém palavras-chave associadas a phishing.');
    });

    test('Link com muitos caracteres especiais', () async {
      String result = await apiService.analyzeLink('https://example@#\$.com');
      expect(result, 'Cuidado! Esse link contém muitos caracteres incomuns e pode ser suspeito.');
    });
  });
}
