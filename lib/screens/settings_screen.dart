import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool alertsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Carrega a preferência salva
  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      alertsEnabled = prefs.getBool('alertsEnabled') ?? true;
    });
  }

  // Salva a preferência
  void _savePreferences(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('alertsEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferências',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Ativar alertas de segurança'),
              value: alertsEnabled,
              onChanged: (bool value) {
                setState(() {
                  alertsEnabled = value;
                });
                _savePreferences(value); // Salva a preferência
              },
              activeColor: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Configurações adicionais podem ser adicionadas aqui.',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
