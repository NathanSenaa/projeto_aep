# Projeto AEP - Verificação de Links Suspeitos

## Descrição

Este projeto é um aplicativo Flutter para verificar se um link inserido é seguro ou suspeito. A verificação é feita com base em palavras-chave associadas a phishing e a presença de caracteres especiais no link. O aplicativo também permite que o usuário mantenha um histórico de links verificados.

## Funcionalidades

- **Verificação de Links**: O aplicativo permite que o usuário insira um link, que é verificado com base em:
  - Presença de palavras-chave suspeitas (ex: "win", "free", "offer").
  - Contagem de caracteres especiais.
  - Verificação do protocolo (`http://` ou `https://`).
- **Histórico de Links**: O aplicativo mantém um histórico dos links verificados.
- **Feedback Visual**: O aplicativo exibe ícones e mensagens claras sobre o status do link (seguro, suspeito ou inválido).
- **Carregamento Assíncrono**: Enquanto o link está sendo verificado, o usuário vê um indicador de carregamento.

## Tecnologias Usadas

- **Flutter**: Framework para o desenvolvimento de aplicativos móveis.
- **Dart**: Linguagem de programação utilizada no Flutter.
- **http**: Pacote para realizar requisições HTTP (não utilizado para validação real, mas para verificar protocolos).

## Como Usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/NathanSenaa/projeto_aep
