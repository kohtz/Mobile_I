# 📱 Flutter API List Demo

Um projeto Flutter simples e funcional que consome uma API REST pública e exibe os dados em uma lista dinâmica com tratamento de estados para carregamento, sucesso e erro.

---

## ✨ Funcionalidades

- ✅ Consumo de API com `http`
- ✅ Conversão de JSON para objetos Dart
- ✅ Exibição de dados com `ListView.builder`
- ✅ Controle de estados de carregamento, sucesso e erro
- ✅ Estrutura de código organizada e modular

---

## 📸 Demonstração

| Carregando | Sucesso | Erro |
|-----------|---------|------|
| `CircularProgressIndicator()` | Lista de Cards com título e corpo | Mensagem com botão "Tentar Novamente" |

---

## 🚀 Tecnologias

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [HTTP Package](https://pub.dev/packages/http)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/posts)

---

## 📁 Estrutura do Projeto

```bash
lib/
├── main.dart               # Tela principal com lógica de estados
├── models/
│   └── PostModel.dart      # Modelo de dados dos posts
├── utilidades/
│   └── ApiService.dart     # Serviço genérico para requisições HTTP
````

## Link para página Notion
https://fearless-celsius-18f.notion.site/Projeto-Flutter-Consumo-de-API-Lista-Din-mica-1f23551e747a803ca446d8b79c468c59?pvs=4
