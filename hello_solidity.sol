// SPDX-License-Identifier: MIT
// ライセンスが設定されていないとエディタで警告が出る

// Solidityのパージョン指定
pragma solidity >=0.8.0 <0.9.0;

// Greeterコントラクトを定義
// contractは他の言語のclassのようなもの
contract Greeter {
    // 変数宣言
    // contract直下の変数はブロックチェーンに保存される
    string name;

    // 関数定義
    // calldataは変数がどのように保存されるかを指定する修飾子
    // - storage  データはブロックチェーン上に永続化される
    // - calldata データは関数のスコープ内のみ生存。変更不可
    // - memory   データは関数のスコープ内のみ生存。変更可能
    // publicはアクセス修飾子
    function setName(string calldata _name) public {
        name = _name;
    }

    // viewはこの関数がブロックチェーンの参照のみしていることを示す識別子
    // returns(string memory)は戻り値型の定義
    function hello() public view returns (string memory) {
        return string(bytes.concat(bytes("Hello "), bytes(name)));
    }
}
