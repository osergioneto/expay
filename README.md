# Expay

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

# Expay

<h4 align="center">
	💰 Expay 💸
</h4>
<p align="center">

  <img alt="language version" src="https://img.shields.io/badge/Elixir-v_1.7-339933?logo=elixir">

  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/osergioneto/expay?color=%2304D361">

  <img alt="License" src="https://img.shields.io/badge/license-MIT-brightgreen">

</p>

<p align="center">
  <a href="#-project">Project</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-how-to-use">How to use</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-technologies">Technologies</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-api">API</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-license">License</a>
</p>

## 📋 Project

- Simply API about money deposit, withdraw and transfer between accounts.
<br><br>

<br>

## 💻 How to use

To clone and run this application, you need [Elixir](https://git-scm.com) and [Docker](https://docs.docker.com/engine/install/ubuntu/)/[docker-compose](https://docs.docker.com/compose/install/) installed on your computer. On your command line:

### Clone this repository

```bash
# Enter the command below to clone the repository
$ git clone https://github.com/osergioneto/expay
```

### Running the project

```bash
# Install dependencies with
mix deps.get

# Run docker container with database
docker-compose up -d

# Create and migrate your database with
mix ecto.setup

# Start Phoenix endpoint with
mix phx.server
```

## API

All APIs requests are under `/api` scope.

## Create user

### Request
`POST /users`

```json
// Body
{
	"name": "José da Silva",
	"email": "jose@email.com",
	"email_confirmation": "jose@email.com",
	"document_number": "66274705007",
	"password": "Kb0ySi1C",
	"password_confirmation": "Kb0ySi1C"
}
```
### Response

```json
{
  "message": "User created",
  "user": {
    "account": {
      "agency": "1",
      "balance": 100000,
      "number": "8d332da8-7f28-42be-bd17-1c511712e1b7"
    },
    "email": "jose@email.com",
    "id": "145678f6-672b-4994-8fb2-4d716144afb2",
    "name": "José da Silva"
  }
}
```

## Deposit

### Request
  `POST /accounts/:account_number/deposit/:value`

### Response

```json
{
  "message": "Successful deposit",
  "account": {
    "agency": "1",
    "balance": 117500,
    "number": "8d332da8-7f28-42be-bd17-1c511712e1b7"
  }
}
```

## Withdraw

### Request
  `POST /accounts/:account_number/withdraw/:value`

### Response

```json
{
  "message": "Successful withdraw",
  "account": {
    "agency": "1",
    "balance": 116250,
    "number": "8d332da8-7f28-42be-bd17-1c511712e1b7"
  }
}
```

## Transfer

### Request
  `POST /accounts/transfer`

```json
// Body
{
	"from": "8d332da8-7f28-42be-bd17-1c511712e1b7",
	"to": "36adab94-b310-4070-b7e3-7f65e1f6bb73",
	"value": "23000"
}
```
### Response

```json
{
  "message": "Successful transfer",
  "transfer": {
    "from": "8d332da8-7f28-42be-bd17-1c511712e1b7",
    "to": "36adab94-b310-4070-b7e3-7f65e1f6bb73",
    "value": "133"
  }
}
```

## Get balance

### Request
  `GET /accounts/balance/:account_number`

### Response

```json
{
  "account": {
    "agency": "1",
    "balance": 116250,
    "number": "8d332da8-7f28-42be-bd17-1c511712e1b7"
  }
}
```
<br/>

## 👨‍💻 Technologies

These are the technologies used in this project

💻

- [Elixir](https://elixir-lang.org/)
- [Phoenix](https://www.phoenixframework.org/)

## 📝 License

This project is under the APL 2.0 license. Check [LICENSE](LICENSE.md) for details.

---

Made by Sérgio Deusdedith 👋 <br>
🔗 [Linkedin](https://www.linkedin.com/in/osergioneto/) <br>
✉ [sergio.deusdedith@gmail.com](mailto:sergio.deusdedith@gmail.com) &nbsp; <br>