![Billinho](https://imgur.com/YrtmKpu.png)
# **Billinho**

Billinho aims to simulate a payment management API to help students keep track of their monthly fees owed/paid to their educational institution.
## **Objects**
* [**Institution**](#institution)

* [**Student**](#student)

* [**Enrollment**](#enrollment)

* [**Invoice**](#invoice)

# **Getting Started**
## **Requirements**
- Ruby >= 3.1.2

- Rails >= 7.0.4

- Postgresql >= 12

## **Setup**
**Clone the repository**
```shell
git clone git@github.com:mvnribeiro/billinho.git
cd billinho
```
 **Install dependencies**
```shell
bundle install
```

**Setup the database**
```shell
rails db:schema:load
rails db:seed
```

**Start the server**
```shell
rails server
```

Then, you can use [Postman](https://postman.com) to interact with the API.

## **Running tests**
```shell
bundle exec rspec
```


# **Resources**
## **Institution**

|argument | type | description|
|----|----|----|
|`id`| int| the institution id|

`POST /institutions`
```
{ 
    "name": "UNITEST",
    "cnpj": "123436739",
    "type_of": "universidade"
}
```

`GET /institutions`
```
Status 200 OK
[
    {
        "id": 1,
        "name": "Centro Tecnológico Bulhões do Norte",
        "cnpj": "797845872",
        "type_of": "creche"
    },
    {
        "id": 2,
        "name": "Universidade de Assunção do Oeste",
        "cnpj": "746394238",
        "type_of": "escola"
    }
]
```
`GET /institutions/:id`
```
Status 200 OK
[
    {
        "id": 4,
        "name": "Universidade Castelo do Nordeste",
        "cnpj": "175488307",
        "type_of": "universidade"
    }
]
```
`DELETE /institutions/:id`
```
Status 204 No Content
```
## **Student**

|argument | type | description|
|----|----|----|
|`id`| int| the student id|

`POST /students`
```
{ 
    "name": "Teste da Silva",
    "cpf": 12345671900,
    "birth_date": "1970-07-23",
    "phone": "99222227777",
    "gender": "M",
    "payment_method": "boleto"
}
```

`GET /students`
```
Status 200 OK
[
    {
        "id": 1,
        "name": "Roberto Garcês Fernandes",
        "cpf": "05006931531",
        "birth_date": "1949-10-19",
        "phone": "11940095950",
        "gender": "M",
        "payment_method": "cartão"
    },
    {
        "id": 2,
        "name": "Luiz Henrique Nunes Caseira Rameira",
        "cpf": "04329088622",
        "birth_date": "1944-09-29",
        "phone": "69981956685",
        "gender": "O",
        "payment_method": "boleto"
    }
]
```
`GET /students/:id`
```
Status 200 OK
[
    {
        "id": 8,
        "name": "Amanda da Bandeira Galego Castro",
        "cpf": "04783787182",
        "birth_date": "2000-06-17",
        "phone": "91912083493",
        "gender": "F",
        "payment_method": "boleto"
    }
]
```
`DELETE /students/:id`
```
Status 204 No Content
```

## **Enrollment**

|argument | type | description|
|----|----|----|
|`id`| int| the enrollment id|

`POST /enrollments`
```
{ 
    "institution_id": 1,
    "student_id": 1,
    "course_name": "Matemática",
    "total_value": 58200.00,
    "total_invoices": 48,
    "due_day": 31
}
```

`GET /enrollments`
```
Status 200 OK
[
    {
        "id": 1,
        "institution_id": 1,
        "student_id": 122,
        "course_name": "Ciência da Computação",
        "total_value": "86545.95",
        "total_invoices": 60,
        "due_day": 28
    },
    {
        "id": 2,
        "institution_id": 5,
        "student_id": 2,
        "course_name": "Matemática",
        "total_value": "91088.69",
        "total_invoices": 60,
        "due_day": 16
    }
]
```
`GET /enrollments/:id`
```
Status 200 OK
[
    {
        "id": 11,
        "institution_id": 7,
        "student_id": 98,
        "course_name": "Filosofia",
        "total_value": "91088.69",
        "total_invoices": 48,
        "due_day": 15
    }
]
```
`DELETE /enrollments/:id`
```
Status 204 No Content
```

## **Invoice**
|argument | type | description|
|----|----|----|
|`id`| int| the institution or student id|

Generated after `enrollment` creation

`GET /students/:id/invoices`
```
Status 200 OK
[
    {
        "id": 1,
        "enrollment_id": 9,
        "institution_id": 144,
        "student_id": 17889,
        "value": "4808.11",
        "due_date": "2022-10-28",
        "status": "aberta"
    },
    {
        "id": 2,
        "enrollment_id": 1,
        "institution_id": 1,
        "student_id": 1,
        "value": "4808.11",
        "due_date": "2022-11-28",
        "status": "aberta"
    }

  ...
]
```

`GET /institution/:id/invoices`
```
Status 200 OK
[
    {
        "id": 1,
        "enrollment_id": 66,
        "institution_id": 234,
        "student_id": 655,
        "value": "613.49",
        "due_date": "2022-10-11",
        "status": "aberta"
    },
    {
        "id": 2,
        "enrollment_id": 66,
        "institution_id": 234,
        "student_id": 655,
        "value": "613.49",
        "due_date": "2022-11-11",
        "status": "aberta"
    }

  ...
]
```


