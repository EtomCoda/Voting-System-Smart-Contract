// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Counter{
    uint public counter = 0;

    function get() public view returns(uint){
        return counter ;
    }

    function increment() public {
        counter ++;
    }
    function decrement() public {
        counter --;
    }


}