## JSON RPC API validation

this is a quick test of using [dredd](https://dredd.org) to validate our RPC API for use with CI systems like TravisCI

## Quickstart

1. install dredd (https://dredd.org/en/latest/installation.html)
   
   `npm i -g dredd` if you already have NodeJS

2. from this folder (make sure the `api-description.apib` file is available) run

    `./test.sh`

3. that's it.  you should see something like

   ```bash
   pass: POST (200) / duration: 349ms
   pass: POST (200) / duration: 268ms
   complete: 2 passing, 0 failing, 0 errors, 0 skipped, 2 total
   complete: Tests took 619ms
   ```

4. or if you're debugging, lots lots more
   ```bash
   2020-02-24T20:58:27.850Z - debug: Loading configuration file: ./dredd.yml
   2020-02-24T20:58:27.852Z - debug: Dredd version: 13.0.1
   2020-02-24T20:58:27.852Z - debug: Node.js version: v13.7.0
   ...
   pass: POST (200) / duration: 356ms
   ...
   pass: POST (200) / duration: 322ms
   ...
   complete: 2 passing, 0 failing, 0 errors, 0 skipped, 2 total
   complete: Tests took 682ms
   ```

## NEAR API is JSON RPC over HTTP

https://docs.nearprotocol.com/docs/interaction/rpc 


### Validation spec

- use API Blueprint for this  \
  https://apiblueprint.org/documentation/tutorial.html

- JSON schema has solid docs too  \
  http://json-schema.org/learn/

- use JSON Schema Lint to validate schema definition against a sample  \
  https://jsonschemalint.com/#!/version/draft-07/markup/json

- use JSON Lint lint my JSON schema if there were issues with the above  \
  https://jsonlint.com/


## Resources

here's an example that you can use with both of these links to try things out

### Schema

```json
{
	"type": "object",
	"properties": {
		"id": {
			"type": "string"
		},
		"jsonrpc": {
			"type": "string"
		},
		"result": {
			"type": "object",
			"properties": {
				"chain_id": {
					"type": "string"
				},
				"rpc_addr": {
					"type": "string"
				},
				"validators": {
					"type": "array",
					"items": {
						"type": "object",
						"properties": {
							"account_id": {
								"type": "string"
							},
							"is_slashed": {
								"type": "boolean"
							}
						}
					}
				},
				"version": {
					"type": "object",
					"properties": {
						"build": {
							"type": "string"
						},
						"version": {
							"type": "string"
						}
					}
				},
				"sync_info": {
					"type": "object",
					"properties": {
						"latest_block_hash": {
							"type": "string"
						},
						"latest_block_height": {
							"type": "number"
						},
						"latest_block_time": {
							"type": "string"
						},
						"latest_state_root": {
							"type": "string"
						},
						"syncing": {
							"type": "boolean"
						}
					}
				}
			}
		}
	}
}
```

### Response

`http https://rpc.nearprotocol.com/\?123 jsonrpc=2.0 method=status params:='[]' id=dontcare`

```json
{
  "jsonrpc": "2.0",
  "result": {
    "chain_id": "testnet",
    "rpc_addr": "0.0.0.0:8080",
    "sync_info": {
      "latest_block_hash": "5Da4xtu8DcGBsuyiN3LCdb9pyCRed6A2e1KZtLXFyEQc",
      "latest_block_height": 1033870,
      "latest_block_time": "2020-02-24T20:35:26.352995760Z",
      "latest_state_root": "8dE4q7n8xYeyAehni2ATW7N5xr6eJdCrRk3wbeEsBVZx",
      "syncing": false
    },
    "validators": [
      {
        "account_id": "far",
        "is_slashed": false
      }
    ],
    "version": {
      "build": "16977411-modified",
      "version": "0.4.12"
    }
  },
  "id": "dontcare"
}
```


## Troubleshooting

### Problems with `dredd`

you can debug the dredd command (log level is adjustable, see `dredd --help` for more)

`dredd -l debug api-description.apib https://rpc.nearprotocol.com`

```bash
2020-02-24T20:50:30.634Z - debug: Loading configuration file: ./dredd.yml
2020-02-24T20:50:30.636Z - debug: Dredd version: 13.0.1
2020-02-24T20:50:30.636Z - debug: Node.js version: v13.7.0
2020-02-24T20:50:30.636Z - debug: Node.js environment: node=13.7.0, v8=7.9.317.25-node.28, uv=1.34.1, zlib=1.2.11, brotli=1.0.7, ares=1.15.0, modules=79, nghttp2=1.40.0, napi=5, llhttp=2.0.1, openssl=1.1.1d, cldr=35.1, icu=64.2, tz=2019a, unicode=12.1
2020-02-24T20:50:30.636Z - debug: System version: Darwin 19.3.0 x64
2020-02-24T20:50:30.640Z - debug: npm version: [object Object]
2020-02-24T20:50:30.640Z - debug: Configuration: {"_":["api-description.apib"],"color":true,"l":"debug","loglevel":"debug","dry-run":null,"y":null,"hookfiles":null,"f":null,"language":"nodejs","a":"nodejs","require":null,"server":"https://rpc.nearprotocol.com","g":null,"server-wait":3,"init":false,"i":false,"custom":{"cwd":"/Users/sherif/Documents/code/near/dev/dredd","argv":["-l","debug","api-description.apib","https://rpc.nearprotocol.com"]},"j":[],"names":false,"n":false,"only":[],"x":[],"reporter":[],"r":[],"output":[],"o":[],"header":[],"h":[],"sorted":false,"s":false,"user":null,"u":null,"inline-errors":false,"e":false,"details":false,"d":false,"method":[],"m":[],"path":["api-description.apib","api-description.apib"],"p":["api-description.apib","api-description.apib"],"hooks-worker-timeout":5000,"hooks-worker-connect-timeout":1500,"hooks-worker-connect-retry":500,"hooks-worker-after-connect-wait":100,"hooks-worker-term-timeout":5000,"hooks-worker-term-retry":500,"hooks-worker-handler-host":"127.0.0.1","hooks-worker-handler-port":61321,"config":"./dredd.yml","$0":"/usr/local/bin/dredd"}
2020-02-24T20:50:30.644Z - debug: No backend server process specified, starting testing at once
2020-02-24T20:50:30.644Z - debug: Running Dredd instance.
2020-02-24T20:50:30.644Z - debug: Resolving --require
2020-02-24T20:50:30.644Z - debug: Configuring reporters
2020-02-24T20:50:30.644Z - debug: Using 'base' reporter.
2020-02-24T20:50:30.645Z - debug: Configuring reporters: []
2020-02-24T20:50:30.645Z - debug: Using 'cli' reporter.
2020-02-24T20:50:30.645Z - debug: Preparing API description documents
2020-02-24T20:50:30.645Z - debug: Resolving locations of API description documents
2020-02-24T20:50:30.647Z - debug: Reading API description documents
2020-02-24T20:50:30.650Z - debug: Parsing API description documents
2020-02-24T20:50:30.949Z - debug: Compiling HTTP transactions from API description documents
2020-02-24T20:50:30.955Z - warn: API description parser warning in /Users/sherif/Documents/code/near/dev/dredd/api-description.apib:97 (from line 97 column 1 to line 98 column 1): action with method 'POST' already defined for resource '/'
2020-02-24T20:50:30.955Z - debug: Starting the transaction runner
2020-02-24T20:50:30.955Z - debug: Starting reporters and waiting until all of them are ready
2020-02-24T20:50:30.955Z - debug: Beginning Dredd testing...
2020-02-24T20:50:30.955Z - debug: Sorting HTTP transactions
2020-02-24T20:50:30.956Z - debug: Configuring HTTP transactions
2020-02-24T20:50:30.957Z - debug: Reading hook files and registering hooks
2020-02-24T20:50:30.957Z - debug: Executing HTTP transactions
2020-02-24T20:50:30.957Z - debug: Running 'beforeAll' hooks
2020-02-24T20:50:30.957Z - debug: Processing transaction #1: JSON RPC > Status
2020-02-24T20:50:30.957Z - debug: Running 'beforeEach' hooks
2020-02-24T20:50:30.957Z - debug: Running 'before' hooks
2020-02-24T20:50:30.958Z - debug: Emitting to reporters: test start
2020-02-24T20:50:30.958Z - debug: Performing HTTPS request to the server under test: POST https://rpc.nearprotocol.com/
2020-02-24T20:50:31.267Z - debug: Handling HTTPS response from the server under test
2020-02-24T20:50:31.267Z - debug: Running 'beforeEachValidation' hooks
2020-02-24T20:50:31.267Z - debug: Running 'beforeValidation' hooks
2020-02-24T20:50:31.267Z - debug: Validating HTTP transaction by Gavel.js
2020-02-24T20:50:31.334Z - debug: Running 'afterEach' hooks
2020-02-24T20:50:31.334Z - debug: Running 'after' hooks
2020-02-24T20:50:31.334Z - debug: Evaluating results of transaction execution #1: JSON RPC > Status
2020-02-24T20:50:31.335Z - debug: Emitting to reporters: test pass
pass: POST (200) / duration: 377ms
2020-02-24T20:50:31.335Z - debug: Processing transaction #2: JSON RPC > Query Account
2020-02-24T20:50:31.335Z - debug: Running 'beforeEach' hooks
2020-02-24T20:50:31.335Z - debug: Running 'before' hooks
2020-02-24T20:50:31.335Z - debug: Emitting to reporters: test start
2020-02-24T20:50:31.335Z - debug: Performing HTTPS request to the server under test: POST https://rpc.nearprotocol.com/
2020-02-24T20:50:31.587Z - debug: Handling HTTPS response from the server under test
2020-02-24T20:50:31.587Z - debug: Running 'beforeEachValidation' hooks
2020-02-24T20:50:31.588Z - debug: Running 'beforeValidation' hooks
2020-02-24T20:50:31.588Z - debug: Validating HTTP transaction by Gavel.js
2020-02-24T20:50:31.605Z - debug: Running 'afterEach' hooks
2020-02-24T20:50:31.605Z - debug: Running 'after' hooks
2020-02-24T20:50:31.605Z - debug: Evaluating results of transaction execution #2: JSON RPC > Query Account
2020-02-24T20:50:31.605Z - debug: Emitting to reporters: test pass
pass: POST (200) / duration: 270ms
2020-02-24T20:50:31.605Z - debug: Running 'afterAll' hooks
2020-02-24T20:50:31.605Z - debug: Wrapping up testing and waiting until all reporters are done
complete: 2 passing, 0 failing, 0 errors, 0 skipped, 2 total
complete: Tests took 650ms
2020-02-24T20:50:31.605Z - debug: Dredd instance run finished.
2020-02-24T20:50:31.606Z - debug: Using native process.exit() method to terminate the Dredd process with status '0'.
2020-02-24T20:50:31.606Z - debug: No backend server process to terminate.
```

### Problems with JSON RPC API

assuming you're using HTTPie (`brew info httpie`) then you can also debug HTTPie at the console to get details of the Request params for dredd using the `-v` flag at the command line

`http -v post https://rpc.nearprotocol.com/\?123 jsonrpc=2.0 method=status params:='[]' id=dontcare`

```bash
POST / HTTP/1.1
Accept: application/json, */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Length: 70
Content-Type: application/json
Host: rpc.nearprotocol.com
User-Agent: HTTPie/2.0.0

{
    "id": "dontcare",
    "jsonrpc": "2.0",
    "method": "status",
    "params": []
}

HTTP/1.1 200 OK
Alt-Svc: clear
Content-Length: 452
Content-Type: application/json
Date: Mon, 24 Feb 2020 20:49:58 GMT
Server: nginx/1.14.0 (Ubuntu)
Via: 1.1 google

{
    "id": "dontcare",
    "jsonrpc": "2.0",
    "result": {
        "chain_id": "testnet",
        "rpc_addr": "0.0.0.0:8080",
        "sync_info": {
            "latest_block_hash": "EterGMXBfF8CbLSwNmTMQKrHjCyCrmpzrNowHUdNMESg",
            "latest_block_height": 1034694,
            "latest_block_time": "2020-02-24T20:49:57.770968367Z",
            "latest_state_root": "EM1XdU7mfrZexH4oMEtZ3cAsbgcThmJdHaF6Cz1CmSgv",
            "syncing": false
        },
        "validators": [
            {
                "account_id": "far",
                "is_slashed": false
            }
        ],
        "version": {
            "build": "16977411-modified",
            "version": "0.4.12"
        }
    }
}
```

## Known Issues

- `dredd` seems to assume a RESTful API so it warns if you overload a resource + method combination (ie. `POST`ing to `/`).  since this is our entire API, we'll see this warning.  i did not investgate a way to turn off this warning.
