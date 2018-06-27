# HubFintech's Challenge API Technical Information

| Summary                                                                                          |
|--------------------------------------------------------------------------------------------------|
| [Getting Started](#getting-started-go-to-summary)                                                |
| [System Dependencies](#system-dependencies-go-to-summary)                                        |
| [Database Creation](#database-creation-go-to-summary)                                            |
| [Running Specs](#running-specs-go-to-summary)                                                    |
| [Rocket Launch](#rocket-launch-go-to-summary)                                                    |
| [API Documentation](#api-documentation-go-to-summary)                                            |
| [Author](#author-go-to-summary)                                                                  |


## Getting Started - [go to summary](#hubfintechs-challenge-technical-information)
These instructions will get you a copy of the project up and running on your local environment for development 
and testing purposes.

## System Dependencies - [go to summary](#hubfintechs-challenge-technical-information)
* Ruby Version `2.5.0`
* Rails Version `5.2.0`
* Database `PostgreSQL`
* Rails Server `Puma`

## Database Creation - [go to summary](#hubfintechs-challenge-technical-information)
Running the application for the first time?
 
  * Then, rename `config/database.sample.yml` file to `config/database.yml`, open the `config/database.yml` 
    file and place informations for (`database`, `username`, `password` and `host`) for the environments you want 
    to run (`development` and `test`);

  * Then, run the commands to create and migrate database according to the wanted environment:
      * `rails db:create:all` 
      * `RAILS_ENV=development rails db:migrate`
      * `RAILS_ENV=test rails db:migrate`

## Running Specs - [go to summary](#hubfintechs-challenge-technical-information)
  * To run the specs, you can:
        * Run `bin/rspec` in the project directory to run all the specs;
        * Run `bundle exec guard` to constant tests feedback. Read more [here](https://github.com/Codaisseur/terminal-notifier-guard) for the configuration process.

## Rocket Launch - [go to summary](#hubfintechs-challenge-technical-information)
  (:rocket: :smile:)
  * And finally, to run the application according to the wanted environment:
      * `rails start` for development environment 
      * `rails start -e test` for test environment

## API Documentation - [go to summary](#hubfintechs-challenge-technical-information)

|                                                     API Summary                                                      |
|----------------------------------------------------------------------------------------------------------------------|
| [Base URL](#base-url-go-to-api-summary)                                                                              |
| [Create Account](#create-account-go-to-api-summary)                                                                  |
| [Show Account](#show-account-go-to-api-summary)                                                                      |
| [Update Account](#update-account-go-to-api-summary)                                                                  |
| [Delete Account](#delete-account-go-to-api-summary)                                                                  |
| [List Transactions](#list-transactions-go-to-api-summary)                                                            |
| [Create Transfer Transaction](#create-transfer-transaction-go-to-api-summary)                                        |
| [Create Contribution Transaction](#create-contribution-transaction-go-to-api-summary)                                |
| [Create Reversal Transaction](#create-reversal-transaction-go-to-api-summary)                                        |

### Base URL - [go to API summary](#api-documentation-go-to-summary)

#### Development
`BASE_URL = http://localhost:3000/v1/`

### Create Account - [go to API summary](#api-documentation-go-to-summary)
`POST BASE_URL/accounts` - [Check out base URL](#base-url-go-to-api-summary)
- Request
  - body:
    - account(*object*)
        - name (*string*) - *Account name*
        - person_type (*string*) - *Accepts only one of these values <`corporation` (For "Pessoa Jurídica ") and `individual` (For "Pessoa Física")>*
        - birthdate (*date*) - *Individual's date of birth* 
        - cpf (*string*) - *Individual's ID*
        - full_name (*string*) - *Individual's full name*
        - cnpj (*string*) - *Corporation's ID*
        - social_name (*string*) - *Corporation's social name ("Razão Social")*
        - trade_name (*string*) - *Corporation's trade name ("Nome Fantasia")*
        - parent_id (*integer*) - *To create matrix accounts ("Conta Matrix")*
- Success Response
  - status: `201`
  - body:
      - data (*object*)
          - id (*integer*)
          - type (*string*)
          - attributes (*object*)
            - name (*string*)
            - account-status (*string*)
            - account-type (*string*)
            - balance (*string*)
          - relationships (*object*)
            - person (*object*)
              - data (*object*)
                - id (*integer*)
                - birthdate (*string*)
                - cpf (*string*)
                - full_name (*string*)
                - cnpj (*string*)
                - social_name (*string*)
                - trade_name (*string*)
                - account_id (*integer*)
                - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
                - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### Create Account Request Examples

##### Create [Matrix] account with [corporation] person:
###### Request Body:
#
```JSON
{
	"account": {
		"name": "Test Account",
		"person_type": "corporation",
		"cnpj": "12345678901234",
		"social_name": "Test Co.",
		"trade_name": "Test Co. 2"
	}
}
````
###### Response Body:
#
```JSON
{
	"data": {
		"id": "30",
		"type": "accounts",
		"attributes": {
			"name": "Test Account",
			"account-status": "active",
			"account-type": "matrix",
			"balance": "0.0"
		},
		"relationships": {
			"person": {
				"data": {
					"id": 28,
					"cnpj": "12345678901234",
					"cpf": null,
					"social_name": "Test Co.",
					"trade_name": "Test Co. 2",
					"full_name": null,
					"birthdate": null,
					"account_id": 30,
					"created_at": "2018-06-25T18:43:54.956Z",
					"updated_at": "2018-06-25T18:43:54.956Z"
				}
			}
		}
	}
}
```
##### Create [Branch] account with [individual] person:
###### Request Body:
#
```JSON
{
	    "account": {
		    "name": "Test Account",
		    "person_type": "individual",
		    "cnpj": "12345678901234",
		    "social_name": "Test Co.",
		    "trade_name": "Test Co. 2",
		    "parent_id": 29
	    }
    }
````
###### Response Body:
#
```JSON
{
	"data": {
		"id": "30",
		"type": "accounts",
		"attributes": {
			"name": "Test Account",
			"account-status": "active",
			"account-type": "branch",
			"balance": "0.0"
		},
		"relationships": {
			"person": {
				"data": {
					"id": 28,
					"cnpj": null,
					"cpf": ""12345678901,
					"social_name": null,
					"trade_name": null,
					"full_name": "John Doe",
					"birthdate": "2018-06-24",
					"account_id": 30,
					"created_at": "2018-06-25T18:43:54.956Z",
					"updated_at": "2018-06-25T18:43:54.956Z"
				}
			}
		}
	}
}
```

### Show Account - [go to API summary](#api-documentation-go-to-summary)
`GET BASE_URL/accounts/:id` - [Check out base URL](#base-url-go-to-api-summary)

- Success Response
  - status: `200`
  - body:
      - data (*object*)
          - id (*integer*)
          - type (*string*)
          - attributes (*object*)
            - name (*string*)
            - account-status (*string*)
            - account-type (*string*)
            - balance (*string*)
          - relationships (*object*)
            - person (*object*)
              - data (*object*)
                - id (*integer*)
                - birthdate (*string*)
                - cpf (*string*)
                - full_name (*string*)
                - cnpj (*string*)
                - social_name (*string*)
                - trade_name (*string*)
                - account_id (*integer*)
                - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
                - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

### Update Account - [go to API summary](#api-documentation-go-to-summary)
`PUT BASE_URL/accounts/:id` - [Check out base URL](#base-url-go-to-api-summary)

- Request
  - body:
    - account(*object*)
        - name (*string*) - *Account name*
        - account_status (*string*) - *Accepts only one of these values <`active`, `blocked` and `canceled`)>*
        - birthdate (*date*) - *Individual's date of birth* 
        - cpf (*string*) - *Individual's ID*
        - full_name (*string*) - *Individual's full name*
        - cnpj (*string*) - *Corporation's ID*
        - social_name (*string*) - *Corporation's social name ("Razão Social")*
        - trade_name (*string*) - *Corporation's trade name ("Nome Fantasia")*
- Success Response
  - status: `200`
  - body:
      - data (*object*)
          - id (*integer*)
          - type (*string*)
          - attributes (*object*)
            - name (*string*)
            - account-status (*string*)
            - account-type (*string*)
            - balance (*string*)
          - relationships (*object*)
            - person (*object*)
              - data (*object*)
                - id (*integer*)
                - birthdate (*string*)
                - cpf (*string*)
                - full_name (*string*)
                - cnpj (*string*)
                - social_name (*string*)
                - trade_name (*string*)
                - account_id (*integer*)
                - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
                - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### Update Account Request Example
###### Request Body:
#
```JSON
{
	"account": {
		"name": "Test Account",
		"account_status": "blocked",
		"cnpj": "00000000000000",
		"social_name": "Test Co.",
		"trade_name": "Test Co. 2"
	}
}
````
###### Response Body:
#
```JSON
{
	"data": {
		"id": "24",
		"type": "accounts",
		"attributes": {
			"name": "Test Account",
			"account-status": "blocked",
			"account-type": "branch",
			"balance": "0.0"
		},
		"relationships": {
			"person": {
				"data": {
					"id": 22,
					"cnpj": "00000000000000",
					"cpf": null,
					"social_name": "Test Co.",
					"trade_name": "Test Co. 2",
					"full_name": null,
					"birthdate": null,
					"account_id": 24,
					"created_at": "2018-06-25T02:13:33.471Z",
					"updated_at": "2018-06-25T06:04:56.165Z"
				}
			}
		}
	}
}
```

### Delete Account - [go to API summary](#api-documentation-go-to-summary)
`DELETE BASE_URL/accounts/:id` - [Check out base URL](#base-url-go-to-api-summary)

- Success Response
  - status: `204`

### List Transactions - [go to API summary](#api-documentation-go-to-summary)
`GET BASE_URL/transactions` - [Check out base URL](#base-url-go-to-api-summary)

- Success Response
  - status: `200`
  - body:
    - array of transactions
      - id (*integer*)
      - transaction_type (*string*)
      - transaction_code (*string*)
      - amount (*string*)
      - from_id (*integer*)
      - to_id (*integer*)
      - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
      - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### List Transactions Request Example
###### Response Body:
#
```JSON
[
	{
		"id": 1,
		"transaction_type": "contribution",
		"transaction_code": "f8ee1c",
		"amount": "19.99",
		"from_id": null,
		"to_id": 29,
		"created_at": "2018-06-26T13:29:55.884Z",
		"updated_at": "2018-06-26T13:29:55.884Z"
	},
	{
		"id": 2,
		"transaction_type": "transfer",
		"transaction_code": "0ae3fb",
		"amount": "19.99",
		"from_id": 5,
		"to_id": 9,
		"created_at": "2018-06-26T13:54:07.440Z",
		"updated_at": "2018-06-26T13:54:07.440Z"
	},
	{
		"id": 3,
		"transaction_type": "transfer",
		"transaction_code": "fd29bb",
		"amount": "19.99",
		"from_id": 9,
		"to_id": 5,
		"created_at": "2018-06-26T22:39:28.945Z",
		"updated_at": "2018-06-26T22:39:28.945Z"
	}
]
```

### Create Transfer Transaction - [go to API summary](#api-documentation-go-to-summary)
`POST BASE_URL/transactions` - [Check out base URL](#base-url-go-to-api-summary)
- Request
  - body:
    - transation(*object*)
      - transaction_type (*string*) - *Accepts only one of these values <`transfer` for "Transferências", `contribution` for "Aporte" and `reversal` for "estorno">*
      - amount (*float*) - *amount to transfer or contribute* 
      - from_id (*integer*) - *ID of the account transfering from*
      - to_id (*integer*) - *ID of the account transfering to*
- Success Response
  - status: `201`
  - body:
      - *object*
        - id (*integer*)
        - transaction_type (*string*)
        - transaction_code (*string*)
        - amount (*string*)
        - from_id (*integer*)
        - to_id (*integer*)
        - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
        - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### Create Transfer Transaction Request Example
###### Request Body:
#
```JSON
{
	"transaction": {
		"transaction_type": "Transfer",
		"amount": 10.99,
		"from_id": 5,
		"to_id": 9
	}
}
````
###### Response Body:
#
```JSON
{
	"id": 9,
	"transaction_type": "transfer",
	"transaction_code": "cd4000",
	"amount": "10.99",
	"from_id": 5,
	"to_id": 9,
	"created_at": "2018-06-27T03:38:58.827Z",
	"updated_at": "2018-06-27T03:38:58.827Z"
}
```

### Create Contribution Transaction - [go to API summary](#api-documentation-go-to-summary)
`POST BASE_URL/transactions` - [Check out base URL](#base-url-go-to-api-summary)
- Request
  - body:
    - transation(*object*)
      - transaction_type (*string*) - *Accepts only one of these values <`transfer` for "Transferências", `contribution` for "Aporte" and `reversal` for "estorno">*
      - from_id (*integer*) - *ID of the account transfering from*
      - to_id (*integer*) - *ID of the account transfering to*
- Success Response
  - status: `201`
  - body:
      - *object*
        - id (*integer*)
        - transaction_type (*string*)
        - transaction_code (*string*)
        - amount (*string*)
        - from_id (*integer*)
        - to_id (*integer*)
        - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
        - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### Create Contribution Transaction Request Example
###### Request Body:
#
```JSON
{
	"transaction": {
		"transaction_type": "Contribution",
		"amount": 10.99,
		"to_id": 29
	}
}
````
###### Response Body:
#
```JSON
{
	"id": 10,
	"transaction_type": "contribution",
	"transaction_code": "40a4f0",
	"amount": "19.99",
	"from_id": null,
	"to_id": 29,
	"created_at": "2018-06-27T03:51:14.997Z",
	"updated_at": "2018-06-27T03:51:14.997Z"
}
```

### Create Reversal Transaction - [go to API summary](#api-documentation-go-to-summary)
`POST BASE_URL/transactions` - [Check out base URL](#base-url-go-to-api-summary)
- Request
  - body:
    - transation(*object*)
      - transaction_type (*string*) - *Accepts only one of these values <`transfer` for "Transferências", `contribution` for "Aporte" and `reversal` for "estorno">*
      - transaction_code (*string*) - *Code of transaction to be reverted*
- Success Response
  - status: `201`
  - body:
      - *object*
        - id (*integer*)
        - transaction_type (*string*)
        - transaction_code (*string*)
        - amount (*string*)
        - from_id (*integer*)
        - to_id (*integer*)
        - created_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)
        - updated_at (*date - ISO8601 format - ``YYYY-MM-DDThh:mm:ssTZD``*)

#### Create Reversal Transaction Request Example
###### Request Body:
#
```JSON
{
	"transaction": {
		"transaction_type": "Reversal",
		"transaction_code": "c5a1ff"
	}
}
````
###### Response Body:
#
```JSON
{
	"id": 11,
	"transaction_type": "reversal",
	"transaction_code": "dd76c7",
	"amount": "19.99",
	"from_id": 5,
	"to_id": 9,
	"created_at": "2018-06-27T03:55:26.089Z",
	"updated_at": "2018-06-27T03:55:26.089Z"
}
```

### Author - [go to summary](#hubfintechs-challenge-technical-information)
* [Euclides Fernandes](https://github.com/3fernandez)
