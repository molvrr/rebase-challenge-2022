# Rebase Challenge 2022

API em Ruby para listagem de exames médicos.

## Tech Stack

* [Docker](https://www.docker.com/)
* [Ruby](https://www.ruby-lang.org/pt/)
* [PostgreSQL](https://www.postgresql.org/)
* [Redis](https://redis.io/)

## Rodando o projeto

1. Execute o seguinte comando no terminal:

```bash
$ docker compose up -d
```

2. Configure o banco de dados:

```bash
$ docker exec -ti rubinho rake db:setup
```

3. Importe os dados do data.csv para o banco de dados:

```bash
$ docker exec -ti rubinho rake db:import
```

## Testes
Para rodar os testes da aplicação
```bash
$ docker exec -ti rubinho bundle exec rspec
```

## API
[Documentação](API.md)

## Monitoramento de Fila
Para monitorar a fila basta acessar o painel web no endereço http://localhost:3535
