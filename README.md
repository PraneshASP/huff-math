```
                                             ,...,
                                          ,::::::<
                                         ,::/^\"``.
                                        ,::/, `   e`.
                                       ,::; |        '.
                                       ,::|  \___,-.  c)
                                       ;::|     \   '-'
                                       ;::|      \
                                       ;::|   _.=`\
                                       `;:|.=` _.=`\
                                         '|_.=`   __\
                                         `\_..==`` /
                                          .'.___.-'.
                                         /          \
                                        ('--......--')
                                        /'--......--'\
                                        `"--......--"`



```

<br>
<h1 align="center"> Huff Math </h1>

**Implementation of basic math operations using Huff**

## Setup

```sh
git clone https://github.com/PraneshASP/huff-math.git
cd huff-math
npm i
```

### Building and Testing

To compile your contracts, write:

```sh
npm run compile
```

To test your contracts, write:

```sh
npm run test
```

For more advanced Hardhat usage, please check the [Hardhat documentation](https://hardhat.org/getting-started/).

### Running Fuzz Tests

> As I was facing some issues with the [foundry-huff template](https://github.com/huff-language/foundry-huff), I configured the fuzz tests to run on the local `anvil` node (forked)

Start the anvil node:

```sh
anvil -f <INFURA_URL>
```

In a new terminal, run the fuzz tests:

```
forge test
```
