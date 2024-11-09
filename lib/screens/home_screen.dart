import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/link_check.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController linkController = TextEditingController();
  String message = '';
  String explanation = '';
  bool isSuspicious = false;
  bool isInvalid = false;
  bool isConnectionError = false;
  bool isLoading = false;

  List<LinkCheck> linkHistory = [];

  void checkLink() async {
    String link = linkController.text;

    setState(() {
      isLoading = true;
    });

    if (link.trim().isEmpty) {
      setState(() {
        message = 'Link inválido: campo vazio';
        explanation = 'Por favor, insira um link completo.';
        isInvalid = true;
        isSuspicious = false;
        isConnectionError = false;
        isLoading = false;
      });
      return;
    }

    String result = await apiService.analyzeLink(link);
    setState(() {
      message = result;
      explanation = getExplanation(result);
      isSuspicious = result.contains('Cuidado');
      isInvalid = result.contains('Link inválido');
      isConnectionError = result.contains('Erro de conexão');
      isLoading = false;

      if (!isInvalid && !isConnectionError) {
        linkHistory.insert(
          0,
          LinkCheck(
            link: link,
            isSuspicious: isSuspicious,
            date: DateTime.now(),
          ),
        );
      }
    });
  }

  String getExplanation(String result) {
    if (result.contains('campo vazio')) {
      return 'O campo de link está vazio. Por favor, insira um link válido.';
    } else if (result.contains('formato do link inválido')) {
      return 'O link inserido não está no formato correto. Verifique se ele contém o protocolo http:// ou https://';
    } else if (result.contains('suspeito')) {
      return 'Este link contém palavras-chave associadas a links perigosos ou possui caracteres suspeitos.';
    } else if (result.contains('deve começar com http:// ou https://')) {
      return 'O link deve começar com http:// ou https:// para ser considerado seguro.';
    } else if (result.contains('parece seguro')) {
      return 'Esse link parece ser seguro, mas sempre tenha cautela ao clicar em links desconhecidos.';
    }
    return '';
  }

  void clearHistory() {
    setState(() {
      linkHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('Verificação de Links'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verifique Links Suspeitos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Insira o link abaixo para verificar se ele é seguro.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: 'Insira o link',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: checkLink,
                child: Text(
                  'Verificar Link',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (isLoading) 
              Center(child: CircularProgressIndicator()),
            if (message.isNotEmpty && !isLoading)
              Center(
                child: Column(
                  children: [
                    Icon(
                      isInvalid || isConnectionError
                          ? Icons.error_outline
                          : (isSuspicious ? Icons.warning : Icons.check_circle),
                      color: isInvalid || isConnectionError
                          ? Colors.red
                          : (isSuspicious ? Colors.red : Colors.green),
                      size: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isInvalid || isConnectionError
                            ? Colors.red
                            : (isSuspicious ? Colors.red : Colors.green),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      explanation,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 30),
            Text(
              'Histórico de Verificações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: clearHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Limpar Histórico'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: linkHistory.length,
                itemBuilder: (context, index) {
                  final item = linkHistory[index];
                  return ListTile(
                    leading: Icon(
                      item.isSuspicious ? Icons.warning : Icons.check_circle,
                      color: item.isSuspicious ? Colors.red : Colors.green,
                    ),
                    title: Text(item.link),
                    subtitle: Text(
                      'Verificado em ${item.date}',
                      style: TextStyle(color: Colors.grey),
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
