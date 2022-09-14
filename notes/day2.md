# Day 2 - Ligo Smart Contract Developer Training

- how compiler works
- what is a contract in Michelson

## Compiler Overview

- libraries are interoperable with all flavors
- parser for each syntax into IR
- sound type checking
- typed IR
- OCaml and Coq

### Types

- native Types
  - `int`, `nat`, `tez`, `bytes`, etc
- tuples
  - `[t1, ..., tn]`
- records
  - `{ f1 : t1, ... fn : tn }`
- variants
  - `| ["C1", t1] | ["C2", t2] | ...`
- aliases

### Constants and Variables

- local mutations
- pass-by-value

### Pattern Matching

- `match`

### Iteration

- terminal (tail) recursion
- `for` loop
- `while` loop

### Module (Namespace)

```javascript
namespace EURO {
  export type t = nat;
  export let add = ([a, b] : [t, t]) : t => a + b;
  export let zero: t = 0 as nat;
  export let one: t = 1 as nat
}
```

- import as namespace

```javascript
#import "euro.jsligo" "EURO"

type storage = EURO.t;
...
```

## Contract Anatomy

- storage
  - data we will retrieve once the contract has finished execution
- parameter
  - defines interactions with the contract
- operations
  - `type result_ = [list<operation>, storage]`
- behavior
  - `val main : [parameter, storage] => result_`

## Testing a Contract

- tests are written in LIGO
- **mutation testing** primitives
- **property testing** random generation of values
- coverage
- ability to catch errors in transactions

### Example

```javascript
#import "contract.jsligo" "Contract"

let _test_increment = () : bool => {
    let init_storage = 42 as nat;
    let [address, _, _] = Test.originate(Contract.main, init_storage, 0 as tez);
    let contract = Test.to_contract(address);
    let res = Test.transfer_to_contract_exn(contract, (Increment (1)), 1 as mutez);
    return (Test.get_storage(address) == init_storage + 1);
}

let test_increment = _test_increment ()
```
