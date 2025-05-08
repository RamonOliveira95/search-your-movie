# EN

# 🎬 Search Your Movie

## Description

Search Your Movie is a Flutter app for searching movies using the [OMDb API](https://www.omdbapi.com/). It allows users to search for titles, view movie details, and maintain a history of recent searches. The app features light/dark themes and follows a clean architecture, with unit and widget tests.

## ✨ Features

- 🔎 Search for movies by title.
- 📄 View movie details (movie title, release year, genre, and synopsis).
- 🕓 History of the last 5 movies accessed.
- 🌗 Toggle between light and dark themes.
- 💥 State handling: loading, error, and empty states.
- ✅ Unit and widget tests.

## 🧠 Architecture

The project follows Clean Architecture principles, divided into:

- **Domain**: Entities and use cases of the application.
- **Data**: Repository implementations, models, remote data sources, and local storage.
- **Presentation**: UI layer (pages, blocs, widgets).
- **Core**: Shared themes and future dependencies.

## Technologies Used

- **Flutter**: Development framework.
- **Bloc**: State management.
- **API OMDb**: The API that provides movie data.
- **Dio**: Used for making network requests.
- **Shared Preferences**: Used for local data storage.
- **Responsividade**: Ensures compatibility with multiple screen sizes.

### Prerequisites

- Flutter 3.29.2.
- Dart 3.7.2.
- Visual Studio Code.
- An Android or iOS device, or an emulator, configured.
- Tests were performed using Chrome Web, Pixel 5 API 31, and Windows Desktop.

## 🛠️ How to Run

### 1. Clone the repository.

### 2. Open the terminal and run 'flutter pub get'.

### 3. Run the app using the 'flutter run' command on an emulator.

## ✅ Final Considerations

The app was developed with a focus on best practices in architecture and clean code:

- Modular organization following Clean Architecture.
- Clear separation of concerns between layers.
- Use of the Bloc pattern for state management.
- Consuming the OMDb API with error handling and empty state management.
- Reusable components for states (loading, error, empty).
- IMDb-inspired interface, responsive design with support for light/dark themes.
- Unit tests for use cases and widget tests with interaction coverage.
- Commits follow semantic versioning conventions.
- Pagination implemented to list all search results.

## Notes
- To improve the organization of imports in larger projects, it's helpful to create central files like 'pages.dart', 'cases.dart', and 'search.dart'. These files re-export content from directories, making it easier to import multiple files with a single line, thus reducing clutter and keeping the code cleaner. I used these files as examples in this project. While not essential for small projects, they are recommended as the project grows.
- To protect the API key, you can use the 'flutter_dotenv' package. I didn’t implement this in this project to simplify testing and avoid potential issues for others running the code. If I had included it, the API key would have been in the .gitignore to prevent version control and ensure security. In real-world projects, it’s better to either use a backend intermediary to make API calls or store the key securely to avoid exposing it in the code.

## 📋 Checklist

- [x] Organized and modular code.
- [x] Clear separation of concerns (UI, logic, data).
- [x] Adherence to Clean Code principles.
- [x] Error and empty state handling.
- [x] Reusable widgets.
- [x] Semantic commits.
- [x] Unit and widget tests.
- [x] README with setup instructions.

## Author
- Ramon Oliveira - [Linkedin](https://www.linkedin.com/in/ramon-oliveira-developer/)

## Test Video Using Pixel 5 API 31 Emulator

https://github.com/user-attachments/assets/9da35626-0cfe-479c-9aec-440b97b0bd7a


# PT-BR

# 🎬 Search Your Movie

## Descrição

Search Your Movie é um aplicativo Flutter para busca de filmes utilizando a [OMDb API](https://www.omdbapi.com/). Ele permite pesquisar títulos, visualizar detalhes dos filmes e manter um histórico de buscas recentes. O app possui tema claro/escuro e segue uma arquitetura limpa, com testes de unidade e widget.

## ✨ Funcionalidades

- 🔎 Pesquisa de filmes por título.
- 📄 Visualização de detalhes do filme (título do filme, ano de lançamento, gênero e sinopse).
- 🕓 Histórico com os 5 últimos filmes acessados.
- 🌗 Alternância entre tema claro e escuro.
- 💥 Tratamento de estados: carregando, erro e vazio.
- ✅ Testes de unidade e de widget.

## 🧠 Arquitetura

O projeto segue os princípios da Clean Architecture, dividido em:

- **Domain**: Entidades e casos de uso da aplicação.
- **Data**: Implementações de repositórios, modelos, fontes remotas e armazenamento local.
- **Presentation**: Camada responsável pela interface com o usuário (páginas, blocos, widgets).
- **Core**: Temas e futuras dependências compartilhadas.

## Tecnologias Usadas

- **Flutter**: Framework de desenvolvimento.
- **Bloc**: Gerenciamento de estado da aplicação.
- **API OMDb**: A API que fornece dados sobre os filmes.
- **dio**: Utilizado para fazer as requisições.
- **shared_preferences**: Utilizado para manter os dados localmente.
- **Responsividade**

### Pré-requisitos

- Flutter 3.29.2.
- Dart 3.7.2.
- Visual Studio Code.
- Um dispositivo Android ou iOS, ou um emulador, configurado.
- Os testes foram feitos utilizando Chrome Web, Pixel 5 API 31 e Windows Desktop.

## 🛠️ Como executar

### 1. Clone o repositório

### 2. Abra o terminal e rode 'flutter pub get'

### 3. Execute o app através de um emulador usando o comando 'flutter run' no terminal

## ✅ Considerações Finais

O app foi desenvolvido com foco em boas práticas de arquitetura e código limpo:

- Organização modular seguindo Clean Architecture.
- Separação clara de responsabilidades entre camadas.
- Uso do padrão Bloc para gerenciamento de estado.
- Consumo da API OMDb com tratamento de erros e estados vazios.
- Componentes reutilizáveis para estados (carregando, erro, vazio).
- Interface inspirada no IMDb, responsiva e com suporte a tema claro/escuro.
- Testes de unidade para casos de uso e testes de widget com cobertura de interações.
- Commits realizados seguindo convenção semântica.
- Paginação implementada para listar todos os resultados da busca.

## Observações
- Para melhorar a organização dos imports em projetos maiores, é útil criar arquivos centralizadores como 'pages.dart', 'cases.dart' e 'search.dart'. Eles reexportam o conteúdo das pastas, facilitando o import de múltiplos arquivos com uma única linha. Isso evita vários imports separados e mantém o código mais limpo. No projeto, usei esses arquivos como exemplo. Embora não sejam essenciais em projetos pequenos, são recomendados à medida que o projeto cresce.
- Para proteger a chave da API, é possível usar o pacote 'flutter_dotenv'. Não implementei neste projeto para facilitar os testes e evitar problemas na execução por outras pessoas, se eu adicionasse não seria compartilhado a api_key, pois estaria na lista do .gitignore para não ser versionada e isso atrapalharia a usabilidade por outras pessoas. Mas seria o ideal em projetos reais, ou melhor ainda seria utilizar um backend intermediando as chamadas, essa abordagem já ajuda a evitar o compartilhamento direto da key no código e garantiria maior segurança.

## 📋 Checklist

- [x] Código organizado e modularizado
- [x] Separação de responsabilidades (UI, lógica, dados)
- [x] Boas práticas de Clean Code
- [x] Tratamento de erros e estados vazios
- [x] Uso de widgets reutilizáveis
- [x] Commits semânticos
- [x] Testes unitários e de widget
- [x] README explicando como rodar o app

## Autor
- Ramon Oliveira - [Linkedin](https://www.linkedin.com/in/ramon-oliveira-developer/)

## Vídeo teste usando o emulador Pixel 5 API 31

https://github.com/user-attachments/assets/9da35626-0cfe-479c-9aec-440b97b0bd7a
