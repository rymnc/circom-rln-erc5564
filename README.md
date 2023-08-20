<h1 align=center>Rate-Limiting Nullifier circuits in Circom (modified for erc-5564)</h1>
<p align="center">
    <img src="https://github.com/rymnc/circom-rln-erc5564/workflows/Test/badge.svg" width="110">
</p>

<div align="center">

*The project is not audited*

</div>

___

## Usage

To be used in conjunction with the stealth commitment scheme described by [erc-5564](https://github.com/Nerolation/EIP-Stealth-Address-ERC), implemented in [erc-5564-bn254](https://github.com/rymnc/erc-5564-bn254)

## What's RLN?

RLN is a zero-knowledge gadget that enables spam 
prevention in anonymous environments.

The core parts of RLN are:
* zk-circuits in Circom (this repo);
* [registry smart-contract](https://github.com/Rate-Limiting-Nullifier/rln-contract);
* set of libraries to build app with RLN ([rlnjs](https://github.com/Rate-Limiting-Nullifier/rlnjs), [zerokit](https://github.com/vacp2p/zerokit)).

---

To learn more on RLN and how it works - check out [documentation](https://rate-limiting-nullifier.github.io/rln-docs/).

## Attribution

The public key derivation is based on [cassiopeia](https://github.com/galletas1712/cassiopeia)