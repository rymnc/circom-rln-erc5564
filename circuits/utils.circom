pragma circom 2.1.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/mux1.circom";
include "../node_modules/circomlib/circuits/bitify.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

include "./lib/bn254.circom";
include "./lib/curve.circom";

template MerkleTreeInclusionProof(DEPTH) {
    signal input leaf;
    signal input pathIndex[DEPTH];
    signal input pathElements[DEPTH];

    signal output root;

    signal mux[DEPTH][2];
    signal levelHashes[DEPTH + 1];
    
    levelHashes[0] <== leaf;
    for (var i = 0; i < DEPTH; i++) {
        pathIndex[i] * (pathIndex[i] - 1) === 0;

        mux[i] <== MultiMux1(2)(
            [
                [levelHashes[i], pathElements[i]], 
                [pathElements[i], levelHashes[i]]
            ], 
            pathIndex[i]
        );

        levelHashes[i + 1] <== Poseidon(2)([mux[i][0], mux[i][1]]);
    }

    root <== levelHashes[DEPTH];
}

template DerivePublicKey() {
    signal input privateKey;

    signal output publicKey[2];

    component bn254_multiplier = EllipticCurveScalarMultiplySignalX(51, 5, 3, bn254_p());

    // Generator for BN254 is (1, 2);
    bn254_multiplier.in[0][0] <== 1;
    bn254_multiplier.in[1][0] <== 2;
    for (var i = 1; i < 5; i++) {
        bn254_multiplier.in[0][i] <== 0;
        bn254_multiplier.in[1][i] <== 0;
    }

    bn254_multiplier.inIsInfinity <== 0;
    bn254_multiplier.x <== privateKey;

    var shifts[5];
    for (var i = 0; i < 5; i++) shifts[i] = 1 << (51 * i);

    var x_out = 0;
    var y_out = 0;
    for (var i = 0; i < 5; i++) {
        x_out += bn254_multiplier.out[0][i] * shifts[i];
        y_out += bn254_multiplier.out[1][i] * shifts[i];
    }

    x_out ==> publicKey[0];
    y_out ==> publicKey[1];
}