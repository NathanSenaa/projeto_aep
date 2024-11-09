class ApiService {
  final List<String> suspiciousKeywords = [
    "free", "click", "win", "prize", "cash", "urgent", "offer",
    "limited", "deal", "promo", "discount", "bonus", "congratulations",
    "verify", "login", "account", "update", "security", "gift", "reward",
    "password", "bank", "alert", "risk", "verify"
  ];

  final RegExp linkPattern = RegExp(
    r'^(https?:\/\/)?([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(\/\S*)?$',
    caseSensitive: false,
  );

  Future<String> analyzeLink(String link) async {
    // Verificação de link vazio
    if (link.trim().isEmpty) {
      return 'Link inválido: campo vazio. Por favor insira um link completo.';
    }

    // Verificação de palavras-chave suspeitas
    for (var keyword in suspiciousKeywords) {
      if (link.toLowerCase().contains(keyword)) {
        return 'Cuidado! Esse link pode ser suspeito. Ele contém palavras-chave associadas a phishing.';
      }
    }

    // Verificação de caracteres especiais
    int specialCharCount = link.replaceAll(RegExp(r'[a-zA-Z0-9]'), '').length;
    if (specialCharCount > 10) {
      return 'Cuidado! Esse link contém muitos caracteres incomuns e pode ser suspeito.';
    }

    // Verificação do formato do link (agora, é importante fazer antes da verificação de protocolo)
    if (!linkPattern.hasMatch(link)) {
      return 'Link inválido: formato do link inválido. Certifique-se de que o link esteja correto.';
    }

    // Verificação de protocolo http:// ou https://
    if (!link.startsWith('http://') && !link.startsWith('https://')) {
      return 'Link inválido: o link deve começar com http:// ou https:// para ser considerado seguro.';
    }

    return 'Esse link parece seguro.';
  }
}
