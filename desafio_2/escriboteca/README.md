# Projeto Escriboteca

Este projeto é um aplicativo Flutter que permite ao usuário baixar, visualizar e favoritar livros de uma biblioteca online.
O aplicativo foi construído em Flutter, utilizando os packages:
- **GetX**: para gerenciamento de estado;
- **Dio**: para solicitações HTTP;
- **Path_provider**: para localizar sistema de arquivos;
- **Vocsy_epub_viewer**: para visualizar arquivos EPUB;
- **Shared_preferences**: para persistência de dados;
- **Shimmer**: para Lazy Loadig.

#### Prototipação: [Acesse o Figma](https://www.figma.com/file/43t2ABcKBXbwslRQJa0CN6/Untitled?type=design&node-id=0%3A1&mode=design&t=8jdzEM8bE8DlLjPD-1)
#### Especificação de Requisitos: [Acesse a ERS](https://drive.google.com/file/d/1cmfsiBYZqxT7VwHCos-MqUc738-ywJfb/view?usp=sharing)
#### Instalação: [Baixe o APK](https://drive.google.com/file/d/1_O3tDhQUG147T36NDFuFf87upns26DWW/view?usp=share_link)

<br>

## Estrutura do Projeto

O projeto é estruturado em várias partes principais:

- **HomePage**: Página inicial do aplicativo. Contém uma `TabBar` com duas abas: 'Biblioteca' e 'Favoritos'. A página inicial também faz a primeira chamada para a API para obter os livros.

- **LibraryTab**: Primeira aba da página inicial, que mostra todos os livros disponíveis na biblioteca em um `GridView`, em que cadaa livro é representado por um `CardBook`.

- **FavoriteTab**: Segunda aba da página inicial, que mostra todos os livros que foram marcados como favoritos pelo usuário.

- **CardBook**: Este widget representa um livro na interface do usuário, exibindo a sua capa, o título e autor.

- **BooksRepository**: Esta classe é responsável por fazer chamadas à API para obter os livros, e mantém uma lista dos livros que foram obtidos.

- **Book**: Esta classe representa o model de um livro, contendo informações como o título, autor, URL da capa e URL de download. Além disso, também contém métodos para salvar e carregar os estados de baixado ou favorito.

- **BookController**: Esta classe é responsável por gerenciar o estado de um livro. Ela contém métodos para baixar, deletar e alternar se o livro é favorito.

