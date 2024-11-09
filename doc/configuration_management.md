# Plano de Gerenciamento de Configuração

## Políticas de Versionamento
Utilizamos o versionamento semântico para este projeto, com o formato `MAJOR.MINOR.PATCH`:
- **MAJOR**: Alterações incompatíveis com versões anteriores.
- **MINOR**: Novas funcionalidades compatíveis com versões anteriores.
- **PATCH**: Correções de bugs e melhorias de performance.

## Controle de Mudanças
As alterações passam por revisões, com documentação clara sobre a motivação e impacto. Cada nova funcionalidade ou correção deve estar associada a uma *branch* específica e passar pela revisão antes de ser integrada na *branch* principal.

## Identificação de Itens de Configuração
- **Código-fonte**: Todos os arquivos de código em `lib/` e `test/`.
- **Documentação**: Arquivos em `doc/` que registram processos e políticas.
- **Dependências**: Gerenciadas pelo `pubspec.yaml`.

## Estrutura de Branches
- **main**: Código estável e pronto para produção.
- **develop**: Branch de desenvolvimento principal.
- **feature/**: Branches para novas funcionalidades.
- **hotfix/**: Branches para correções urgentes de problemas críticos.
