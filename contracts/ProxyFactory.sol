// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts-upgradeable/utils/cryptography/ECDSAUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/ERC1967/ERC1967UpgradeUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
// import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";


contract ProxyFactory{

    event ProxyCreated(address proxy);
    event BeaconCreated(address beacon);

    mapping(address => bool) private _minimalProxies;
    mapping(address => bool) private _transparenrProxies;
    mapping(address => bool) private _beaconProxies;

    UpgradeableBeacon private _beacon;
    bool private _isBeaconSet;

    function deployMinimalOld(address _logic, bytes memory _data) public returns (address proxy) {
        // Adapted from https://github.com/optionality/clone-factory/blob/32782f82dfc5a00d103a7e61a17a5dedbd1e8e9d/contracts/CloneFactory.sol
        bytes20 targetBytes = bytes20(_logic);
        assembly {
            let clone := mload(0x40)
            mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(clone, 0x14), targetBytes)
            mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            proxy := create(0, clone, 0x37)
        }

        emit ProxyCreated(address(proxy));

        if(_data.length > 0) {
            (bool success,) = proxy.call(_data);
            require(success);
        }
    }

    function deployMinimal(address _logic, bytes memory _data) public returns (address) {
        address proxy = ClonesUpgradeable.clone(_logic);
        emit ProxyCreated(address(proxy));
        if(_data.length > 0) {
            (bool success,) = proxy.call(_data);
            require(success);
        }
        return proxy;
    }

    function deployTransparent(address _logic, address _admin, bytes memory _data) public returns (address) {
        bytes memory creationByteCode = codeForTransparentProxy(_logic, _admin, _data);
        TransparentUpgradeableProxy proxy = _deployTransparentProxy(creationByteCode);
        return address (proxy);
    }

    function codeForTransparentProxy(address _logic, address _admin, bytes memory _data)
        public
        pure
        returns (bytes memory)
    {
        bytes memory bytecode = type(TransparentUpgradeableProxy).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_logic, _admin, _data));
    }

    function _deployTransparentProxy(bytes memory _creationByteCode) internal returns (TransparentUpgradeableProxy){
        address payable addr;

        assembly {
            addr := create(0, add(_creationByteCode, 0x20), mload(_creationByteCode))
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        return TransparentUpgradeableProxy(addr);
    }

    // https://docs.openzeppelin.com/contracts/4.x/api/proxy#BeaconProxy-constructor-address-bytes-
    function codeForBeaconProxy(address beacon, bytes memory data) public pure returns (bytes memory) {
        bytes memory bytecode = type(BeaconProxy).creationCode;
        return abi.encodePacked(bytecode, abi.encode(beacon, data));
    }

    function _deployBeaconProxy(bytes memory _creationByteCode) internal returns (BeaconProxy) {
        address payable addr;
        assembly {
            addr := create(0, add(_creationByteCode, 0x20), mload(_creationByteCode))
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        return BeaconProxy(addr);
    }

    function _deployBeacon(address _logic) internal {
        if (!_isBeaconSet) {
            _beacon = new UpgradeableBeacon(_logic);
            _isBeaconSet = true;
            emit BeaconCreated(address (_beacon));
        }
    }

    function getBeacon() public view returns (address) {
        return address(_beacon);
    }

    function deployBeaconProxy(address _logic, bytes memory payload) public returns (address) {
        if (!_isBeaconSet) {
            _deployBeacon(_logic);
        }
        bytes memory code = codeForBeaconProxy(address (_beacon), payload);
        BeaconProxy proxy = _deployBeaconProxy(code);
        _beaconProxies[address (proxy)] = true;
        return address (proxy);
    }

    function upgradeBeacon(address _logic) public {
        _beacon.upgradeTo(_logic);
    }

// 0x57dE05161ea5E8dD0B873128dDEFC5FbD6668c7B
}