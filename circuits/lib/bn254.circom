// forked from https://github.com/galletas1712/cassiopeia/blob/5c9059efaa31ffbf92b96823cd736fcddd5563a5/zkp/lib/bn254.circom#L1C1-L6C2
// inherits license from the above repository

pragma circom 2.0.3;

function bn254_p() {
    var p[5] = [154029749239111, 612489067865988, 1694766016103850, 22935798733632, 851317936231194];
    return p;
}