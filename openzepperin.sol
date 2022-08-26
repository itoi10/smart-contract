// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// isは継承(複数可能)。 ERC721URIStrageとOwnableというinterfaceを継承する
contract SampleERC721 is ERC721URIStorage, Ownable {
    // using A for B; AというライブラリをBに加えるのみ使うことができる?
    // uint256変数がStringsライブラリの関数を呼び出すことができる
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _current_token_id;
    string base_uri = "";

    // コンストラクタ定義
    // ERC721(ERC721URIStorageが継承しているコンストラクタ)のコンストラクタを定義。 引数(NFTの名前, NFTの識別子)
    constructor() ERC721("SampleERC721", "SMP721") {}

    // NFTの発行
    function mint() public returns (uint256) {
        // トークンID割り当て
        uint256 _token_id = _current_token_id.current();
        // 親クラスのmintメソッド呼び出し
        _mint(msg.sender, _token_id);

        // 親クラスのメソッドを呼び出しTokenURIを設定
        _setTokenURI(
            _token_id,
            string(abi.encodePacked(_token_id.toString(), ".json"))
        );

        // トークンIDをインクリメント
        _current_token_id.increment();

        return _token_id;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return base_uri;
    }

    // TokenURIのBaseURI変更
    function setBaseURI(string calldata _base_uri) public {
        // require関数は条件に一致しないコントラクトの実行を中断する。
        // コントラクト実行ユーザとコントラクト作者を比較。
        // これによりBaseURI変更は作者のみ実行できるようにする。
        require(msg.sender == owner());
        base_uri = _base_uri;
    }
}
