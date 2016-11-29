# somata-repl

Interact with Somata services via a REPL.

## Usage

The REPL extends [Hashpipe](https://github.com/spro/hashpipe) with the ability to call somata service methods using this syntax:

```
service.method arg1 arg2 ...
```

```
$ somata-repl

#| hello.sayHello "Jack"
'Hello Jack!'

#| hello.sayGoodbye "Jack"
[ERROR] No method sayGoodbye

#| 
```
## Installation

```
$ npm install -g somata-repl
```
