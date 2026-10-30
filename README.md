# Estudo

Repositório de testes que faço apenas para estudo e autodesenvolvimento. Cada pasta é um experimento independente, sem relação com as demais.

## Conteúdo

| Pasta | Tecnologias | O que é |
|---|---|---|
| [`estudo_backend/`](estudo_backend) | Python, FastAPI | API mínima de aquecimento: rota raiz e CRUD simples de itens em memória (`GET/POST /items`, `GET /items/{id}`). |
| [`projeto_backend/`](projeto_backend) | Python, FastAPI | API de gerenciador de tarefas organizada em camadas: `routes` (recebem a requisição HTTP), `controllers` (regra de negócio), `model` (estrutura e validação dos dados) e `database` (banco falso em memória). As anotações sobre cada camada estão em `notes.txt`. |
| [`estudo_testes_unitarios_e_integracao/`](estudo_testes_unitarios_e_integracao) | Python, pytest | Estudo de testes unitários e de integração, usando um banco falso em memória que imita a interface do Supabase (`table().select().eq().execute()`). |
| [`teste_rede_neural/`](teste_rede_neural) | Python, PyTorch, scikit-learn | Classificador de tipos de documento (nota fiscal, contrato etc.) a partir do texto: vetorização TF-IDF e uma rede neural simples de duas camadas. Contém o treino (`treinar.py`), a inferência (`classificador.py`) e a extração de texto (`extrator.py`). |
| [`teste_compiladores/`](teste_compiladores) | C, Flex, Bison | Exercícios da disciplina de Compiladores: listas 1 a 3 e a prova, com analisadores léxicos (`.l`) e sintáticos (`.y`), incluindo uma calculadora. |

## Como rodar

APIs FastAPI (a partir da pasta do projeto):

```bash
pip install -r requirements.txt   # em projeto_backend/
uvicorn main:app --reload
```

Analisadores de compiladores (a partir da pasta do exercício):

```bash
flex arquivo.l
gcc lex.yy.c -o arquivo
```

Os exercícios com Bison também usam `bison -d arquivo.y` antes do `gcc`.
