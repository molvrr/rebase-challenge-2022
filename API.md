# Endpoints
## GET /tests
Retorna todos os exames cadastrados no banco de dados
### Exemplo de resposta
```json
[
  {
    "result_token": "IWH46D",
    "result_date": "2022-03-03",
    "cpf": "036.662.049-53",
    "name": "Dr. Pedro Resende",
    "birthdate": "1979-11-11",
    "address": "796 Alameda Gúbio Palhares",
    "city": "Meruoca",
    "state": "Rondônia",
    "doctor": {
      "crm": "B000BJ20J4",
      "crm_state": "PI",
      "name": "Maria Luiza Pires",
      "email": "denna@wisozk.biz"
    },
    "test_type": "leucócitos",
    "test_limits": "9-61",
    "test_result": "2"
  },
  {
    "result_token": "IWH46D",
    "result_date": "2022-03-03",
    "cpf": "036.662.049-53",
    "name": "Dr. Pedro Resende",
    "birthdate": "1979-11-11",
    "address": "796 Alameda Gúbio Palhares",
    "city": "Meruoca",
    "state": "Rondônia",
    "doctor": {
      "crm": "B000BJ20J4",
      "crm_state": "PI",
      "name": "Maria Luiza Pires",
      "email": "denna@wisozk.biz"
    },
    "test_type": "plaquetas",
    "test_limits": "11-93",
    "test_result": "24"
  }
]
```
## GET /tests/:token
Retorna todos exames referentes ao token informado
### Exemplo de resposta
```json
{
  "result_token": "IWH46D",
  "result_date": "2022-03-03",
  "cpf": "036.662.049-53",
  "name": "Pedro Resende",
  "email": "ettie@runolfsdottir.name",
  "birthdate": "1979-11-11",
  "doctor": {
    "crm": "B000BJ20J4",
    "crm_state": "PI",
    "name": "Maria Luiza Pires"
  },
  "tests": [
    { "type": "leucócitos", "limits": "9-61", "result": "2" },
    { "type": "plaquetas", "limits": "11-93", "result": "24" },
    { "type": "hdl", "limits": "19-75", "result": "41" },
    { "type": "ldl", "limits": "45-54", "result": "55" },
    { "type": "vldl", "limits": "48-72", "result": "33" },
    { "type": "glicemia", "limits": "25-83", "result": "22" },
    { "type": "tgo", "limits": "50-84", "result": "15" },
    { "type": "tgp", "limits": "38-63", "result": "19" },
    { "type": "eletrólitos", "limits": "2-68", "result": "48" },
    { "type": "tsh", "limits": "25-80", "result": "86" },
    { "type": "t4-livre", "limits": "34-60", "result": "67" },
    { "type": "ácido úrico", "limits": "15-61", "result": "58" },
    { "type": "hemácias", "limits": "45-52", "result": "65" }
  ]
}
```
## POST /import
Endpoint para envio de CSV com dados de exames

O cabeçalho do CSV deve estar na seguinte ordem (utilizando ponto e vírgula como separador):

|cpf|nome paciente|email paciente|data nascimento paciente|endereço/rua paciente|cidade paciente|estado patiente|crm médico|crm médico estado|nome médico|email médico|token resultado exame|data exame|tipo exame|limites tipo exame|resultado tipo exame|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
