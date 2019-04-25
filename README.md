# Apresentação da Aplicação
Essa aplicação é baseada no [desafio proposto pela Stone!](https://gist.github.com/bamorim/39f7ec5ba2c5beff6ff0227a4e6308ca)

No arquivo [desafio-stone-bank.postman_collection.json](https://github.com/Douuuglas/desafio-stone-bank/blob/master/desafio-stone-bank.postman_collection.json.postman_collection.json) existe uma collection do postman pra testar o app :D

## Requerimento/Dependências
Principais:
- [Elixir 1.8.1](https://elixir-lang.org/)
- [Postgres 9.6](https://www.postgresql.org/)
- [phoenix 1.4.2](https://phoenixframework.org/)
- [commanded 0.18](https://hexdocs.pm/commanded/Commanded.html)
- [eventstore 0.16](https://hexdocs.pm/eventstore/EventStore.html)
- [elixir_uuid 1.2](https://hexdocs.pm/elixir_uuid/readme.html)
- [guardian 1.2](https://hexdocs.pm/guardian/introduction-overview.html)

Mais em mix.ex (deps).

## Como Começar
Clonar o repositório:

```
> git clone https://github.com/Douuuglas/desafio-stone-bank.git
> cd "desafio-stone-bank"
```

Criar o BD e migrations:
```
> mix ecto.create
> mix ecto.migrate
```

Inicializar a Event Store:

```
> mix event_store.create
> mix event_store.init
```

Executar os testes:

```
> mix test
```

Iniciar a aplicação:

```
> mix phx.server
```

Executar os testes:

```
> mix test
```

Iniciar a aplicação:

```
> mix phx.server
```

## Objetivos
Alcançados:
 - Saque e transferencia entre contas;
 - Cadastro e ao completar o cadastro ele recebe R$ 1000,00;
 - Envio de e-mail durante o saque;
 - Autenticação para realizar qualquer operação;
 - Docker;
 - EventSourcing;
 - Sistema rodando na nuvem: https://desafiostone.azurewebsites.net/api/;
 - CI: todo push no git inicia um build no [docker/douuuglas/desafio-stone-bank](https://cloud.docker.com/u/douuuglas/repository/docker/douuuglas/desafio-stone-bank) e publica no Azure Web Apps via Webhook.

Pendentes:
 - Ampliar os testes;
 - Relatório no backoffice que dê o total transacionado (R$) por dia, mês, ano e total está incompleto;
 - Monitoramento de logs e falhas no sistema.

## Créditos
Não foi fácil chegar até aqui... muitas palestras assistidas e muita documentção lida!
Algumas:
- [CQRS/ES com Elixir, Bernardo Amorim](https://pt-br.eventials.com/locaweb/cqrs-es-com-elixir-com-bernardo-amorim/)
- [Event Sourcing With Elixir, Bruno Antunes](https://blog.nootch.net/post/event-sourcing-with-elixir-part-1/)
- [Building Conduit](https://leanpub.com/buildingconduit/read)
- [CQRS and Event Sourcing, Bernardo Amorim](https://www.youtube.com/watch?v=S3f6sAXa3-c)
- [Building a CQRS/ES web application in Elixir using Phoenix](https://10consulting.com/2017/01/04/building-a-cqrs-web-application-in-elixir-using-phoenix/)
- [GOTO 2014 Event Sourcing Greg Young](https://www.youtube.com/watch?v=8JKjvY4etTY)
