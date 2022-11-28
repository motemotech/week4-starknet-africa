%lang starknet
from src.ERC721 import name, symbol, balanceOf, ownerOf, getApproved, isApprovedForAll, tokenURI, owner, approve, setApprovalForAll, transferFrom, safeTransferFrom
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_caller_address

const TOKEN_NAME=1692660622325569080943028654924641;
const TOKEN_SYMBOL=5456198;
const ADDRESS1=1281053119216304758513540106334642920127935051047022506196536343449580783866;
const ADDRESS2=1395644750265506800529671270954975641846705462528058357594896269361090330890;

@contract_interface
namespace ERC721 {
    func name() -> (name: felt) {
    }

    func symbol() -> (symbol: felt) {
    }

    func balanceOf(owner: felt) -> (balance: Uint256) {
    }

    func ownerOf(tokenId: Uint256) -> (owner: felt) {
    }

    func getApproved(tokenId: Uint256) -> (isApproved: felt) {
    }

    func isApprovedForAll(owner: felt, operator: felt) -> (isApproved: felt) {
    }

    func tokenURI(tokenId: Uint256) -> (tokenURI: felt){
    }

    func owner() -> (owner: felt) {
    }

    func approve(to: felt, tokenId: Uint256) {
    }

    func setApprovalForAll(operator: felt, approved: felt) {
    }

    func transferFrom(from_: felt, to: felt, tokenId: Uint256) {
    }

    func safeTransferFrom(from_: felt, to: felt, tokenId: Uint256, data_len: felt, data: felt*) {
    }

    func mint(to: felt, tokenId: Uint256) {
    }

    func burn(tokenId: Uint256) {
    }

    func setTokenURI(tokenId: Uint256, tokenURI: felt) {
    }

    func transferOwnership(newOwner: felt) {
    }

    func renounceOwnership() {
    } 

}

@external
func __setup__{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    %{ context.contract_a_address = deploy_contract("./src/ERC721.cairo").contract_address %}
    return ();
}

@external
func test_name{syscall_ptr: felt*, range_check_ptr}() 
{
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    let (token_name) = ERC721.name(contract_address = contract_address);

    assert token_name = TOKEN_NAME;
    return ();
}

@external
func test_symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
) {
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    let (token_symbol) = ERC721.symbol(contract_address = contract_address);

    assert token_symbol = TOKEN_SYMBOL;
    return ();
}

@external
func test_balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
) {
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    ERC721.mint(contract_address=contract_address, to=ADDRESS1, tokenId=Uint256(0,0));
    let (token_balance) = ERC721.balanceOf(contract_address=contract_address, owner = ADDRESS1);

    assert token_balance = Uint256(1, 0);
    return ();
}

@external
func test_ownerOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
) {
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    ERC721.mint(contract_address=contract_address, to=ADDRESS1, tokenId=Uint256(0,0));
    let (token_owner) = ERC721.ownerOf(contract_address=contract_address, tokenId = Uint256(0, 0));

    assert token_owner = ADDRESS1;
    return ();
}

@external
func test_getApproved{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    ERC721.mint(contract_address=contract_address, to=ADDRESS1, tokenId=Uint256(0,0));
    %{ stop_prank = start_prank(ids.ADDRESS2) %}
        let (isApproved) =  ERC721.getApproved(contract_address=contract_address, tokenId=Uint256(0,0));
        assert isApproved = 0;
    %{ stop_prank() %}
    %{ stop_prank = start_prank(ids.ADDRESS1) %}
        ERC721.approve(contract_address=contract_address, to=ADDRESS2, tokenId=Uint256(0,0));
    %{ stop_prank() %}
    %{ stop_prank = start_prank(ids.ADDRESS2) %}
        let (isApproved) =  ERC721.getApproved(contract_address=contract_address, tokenId=Uint256(0,0));
        assert isApproved = 1;
    %{ stop_prank() %}
    return ();
}

@external
func test_transferFrom{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    tempvar contract_address;
    %{ ids.contract_address = context.contract_a_address %}

    ERC721.mint(contract_address=contract_address, to=ADDRESS1, tokenId=Uint256(0,0));
    %{ stop_prank = start_prank(ids.ADDRESS1) %}
        ERC721.transferFrom(contract_address=contract_address, from_=ADDRESS1, to=ADDRESS2, tokenId=Uint256(0,0));
    %{ stop_prank() %}
    %{ stop_prank = start_prank(ids.ADDRESS2) %}
        let (token_owner) = ERC721.ownerOf(contract_address=contract_address, tokenId = Uint256(0, 0));
        assert token_owner = ADDRESS2;
    %{ stop_prank() %}
    return ();
}


// @external
// func setApprovalForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
// }

// @external
// func isApprovedForAll{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
// }
