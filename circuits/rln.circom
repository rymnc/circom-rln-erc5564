pragma circom 2.1.0;

include "./utils.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template RLN(DEPTH) {
    // Private signals
    signal input identitySecret;
    signal input pathElements[DEPTH];
    signal input identityPathIndex[DEPTH];

    // Public signals
    signal input x;
    signal input externalNullifier;

    // Outputs
    signal output y;
    signal output root;
    signal output nullifier;

    signal publicKey[2] <== DerivePublicKey()(identitySecret);
    signal identityCommitment <== Poseidon(2)([publicKey[0], publicKey[1]]);

    // Membership check
    root <== MerkleTreeInclusionProof(DEPTH)(identityCommitment, identityPathIndex, pathElements);

    // SSS share calculations
    signal a1 <== Poseidon(2)([identitySecret, externalNullifier]);
    y <== identitySecret + a1 * x;

    // nullifier calculation
    nullifier <== Poseidon(1)([a1]);
}

component main { public [x, externalNullifier] } = RLN(20);