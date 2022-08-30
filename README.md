# Huffmath • [![Tests](https://github.com/PraneshASP/huff-math/actions/workflows/tests.yaml/badge.svg)](https://github.com/PraneshASP/huff-math/actions/workflows/tests.yaml)[![license](https://img.shields.io/badge/Unlicense-blue.svg?label=license)](https://opensource.org/licenses/unlicense) ![solidity](https://img.shields.io/badge/solidity-%3E%3D0.8.13%20%3C0.9.0-lightgrey)

<h3>

A math library implementation using [**Huff**](https://docs.huff.sh).

</h3>
 
## What?

This repo contains smart contracts for simple math operations implemented using Huff. Though there are testcases implemened the contracts are not audited. Use at your own risk.

### Requirements

The following will need to be installed in order to use this repo. Please follow the links and instructions.

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you've done it right if you can run `git --version`
- [Foundry / Foundryup](https://github.com/gakonst/foundry)
  - This will install `forge`, `cast`, and `anvil`
  - You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
  - To get the latest of each, just run `foundryup`
- [Huff Compiler](https://docs.huff.sh/get-started/installing/)
  - You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.2.0`

### Quickstart

1. Clone this repo:

```
git clone https://github.com/PraneshASP/huff-math
cd huff-math
```

2. Install dependencies

Once you've cloned and entered into your repository, you need to install the necessary dependencies. In order to do so, simply run:

```shell
forge install
```

3. Build & Test

To build and test your contracts, you can run:

```shell
forge build
forge test
```

For more information on how to use Foundry, check out the [Foundry Github Repository](https://github.com/foundry-rs/foundry/tree/master/forge) and the [foundry-huff library repository](https://github.com/huff-language/foundry-huff).

## Blueprint

```ml
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ foundry-huff — https://github.com/huff-language/foundry-huff
src
 ├─ Math.huff — Huff library for simple math operations (experimental)
 ├─ WadRayMath.huff - Optimized Huff library for high presicion math (upto 27 digit decimals)
test
 ├─ Math.t.huff
 └─ WadRayMath.t.huff
```

## License

[The Unlicense](https://github.com/PraneshASP/huff-math/blob/master/LICENSE)

## Acknowledgements

- [foundry-huff-template](https://github.com/huff-language/huff-project-template)
- [Huffmate](https://github.com/pentagonxyz/huffmate)
- [Aave](https://github.com/aave)

## TODO

- [x] Add support for `ln()` and `exp()`
- [ ] Add fuzz tests
- [ ] Handle reverts with reason string??

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
