## 📌 Estrutura do Projeto – vetCare (Resumo)

### 🎯 Objetivo

Desenvolver uma aplicação **Web em Java** com:

* **Backend (API)** em Java (Servlets + JDBC)
* **Frontend simples** com JSP (HTML renderizado no servidor)
* Base de dados **MySQL**
* Foco principal na **organização da API e lógica de negócio**, não no design.

---

## 🧱 Arquitetura adotada

A aplicação segue uma organização inspirada em **MVC**, usando apenas tecnologias base de Java Web (sem frameworks externos):

* **Model** → entidades da base de dados
* **DAO** → acesso à base de dados (SQL/JDBC)
* **API (Servlets)** → endpoints HTTP
* **JSP (Views)** → páginas HTML simples
* **Config** → configuração partilhada (ligação à BD)

---

## 📂 Estrutura de pastas final

### `src/main/java`

```text
org.example.vetcare
├── api
│     └── ListarAnimaisServlet.java
│
├── model
│     └── Animal.java
│
├── dao
│     └── AnimalDao.java
│
├── config
│     └── DbConnection.java
```

### `src/main/webapp`

```text
webapp
├── index.jsp
└── listarAnimais.jsp
```

---

## 🧩 Responsabilidade de cada camada

### 🔹 `model`

* Representa as entidades da base de dados.
* Contém apenas atributos, construtores e getters/setters.
* Exemplo: `Animal`

---

### 🔹 `config`

* Contém classes de configuração global.
* `DbConnection`:

    * centraliza URL, user e password da BD
    * fornece `getConnection()`
    * carrega o driver JDBC uma única vez

---

### 🔹 `dao`

* Camada responsável por **todo o SQL**.
* Usa JDBC para executar `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
* Não conhece Servlets nem JSP.
* Exemplo: `AnimalDao.findAll()`

---

### 🔹 `api` (Servlets)

* Cada ficheiro Java representa um **endpoint HTTP**.
* Recebe pedidos do browser (`GET`, `POST`, etc.).
* Chama métodos do DAO.
* Decide:

    * devolver HTML (forward para JSP), ou
    * devolver dados (ex.: JSON no futuro).
* Exemplo: `/listarAnimais`

---

### 🔹 `webapp` (JSP)

* Parte de **frontend simples**.
* JSP serve apenas para:

    * apresentar dados
    * criar links e formulários
* Não contém SQL nem lógica pesada.
* Usa atributos enviados pelo Servlet (`request.setAttribute`).

---

## 🔁 Fluxo típico da aplicação

1. O utilizador acede a uma página JSP (ex.: `index.jsp`)
2. Clica num link ou submete um formulário
3. O pedido é tratado por um **Servlet** (`api`)
4. O Servlet chama um **DAO**
5. O DAO consulta a **base de dados**
6. O Servlet envia os dados para um **JSP**
7. O JSP gera o HTML final

---

## 🧪 Código de teste

* Classes como `Main`, `testConnection`, menus de consola, etc.
* Usadas apenas para testes iniciais de JDBC.
* **Não fazem parte da aplicação Web final**.
* Podem ser removidas ou movidas para um package de testes (`sandbox`).

---

## 📌 Observações finais

* A aplicação é **Web (JSP + Servlets)**, não consola.
* Os endpoints estão separados por ficheiros `.java`.
* A estrutura permite crescer facilmente:

    * novas entidades → `model`
    * novas operações → `dao`
    * novos endpoints → `api`
    * novas páginas → `webapp`
* Mais tarde, o frontend pode ser substituído (ex.: React) sem mudar o backend.
