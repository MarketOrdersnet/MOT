pragma solidity >=0.4.0 <0.6.0;

// This test script written to assure full-successful test of all function written in MARKETORDERS contract
// MARKETORDERS TOKEN contract is written to control the token program specified by whitepapers with following main data
// name = "MarketOrders Token";
// symbol = "MOT"
// decimals = 18
// totalSupply = 200000000
// It has 7 internal wallets for admin circle, and rest are public wallet
// All 7 internal wallets will receive funds on the pre-defined schedule , from 1 - 36 months
// pre-defined schedule for internal wallet transfer written in contract, which will transfer funds to respective wallet on time to time call by admin
// All 7 wallet defined for different fund categories like seed-sale, marketing, legal, comminity ..... etc.
// This contract has one standared SafeMath library, and 4 helper contracts Initializable, Ownable, Payable, Blacklistable
// All 4 helper contracts are also form of standared contract practice trade , which is the sign of a good contract
// Two admin types defined in the contract Owner and Pauser, Owner has full admin control and pauser can size the contract function when need

// Following are the test cases done through codes
//      Function name               Desctiption
//  1.  initialize                  To set token name,symbol, totalSupply etc just after deploy
//  3.  init                        To defined internal wallets and starting ref date of contracts with transfer schedule set
//  4.  setInternalWalletAddress    To associate address to the internal wallet
//  5.  transferByMetricPlan        To transfer fund from internal wallet to desired address
//  6.  doScheduledTransfer         To transfer fund from totalSupply to internal walled on defined schedule
//  7.  transfer                    Standared ERC20 Transfer
//  8.  transferFrom                Standared ERC20 TransferFrom
//  9. approve                     Helper function for TransferFrom to function
//  10. airDropMultiple             Standared airDropMultiple
//  11. manualWithdrawTokens        Manual withdraw tokens by admin
//  12. manualWithdrawEther         Manual withdraw ether by admin (It needs to pay ether then withdraw, so pls test it manually)

//  NOTE : mot contract contains codes for change basic date of contract (nammed as birthDate in contract)
//  Just for test purpose, the function "change birthDate" should be removed or commented on final deploy

interface MI   // Stands for mot interface
{
    function transferOwnership(address newOwner) external;
    function acceptOwnership() external returns (address);
    function initialize() external;
    function init() external returns (bool); //onlyOwner
    function setInternalWalletAddress(string calldata _forWalletName, address _walletAddress) external returns (bool);
    function transferByMetricPlan(address _interWalletAddress, address to, uint256 amount) external returns (bool);
    function doScheduledTransfer() external returns (uint8);
    function transfer(address _to, uint256 _value) external returns (bool success);
    function burn(uint256 _value) external;
    function approve(address _spender, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function airDropMultiple(address[] calldata recipients,uint[] calldata tokenAmount) external returns (bool);
    function manualWithdrawTokens(uint256 tokenAmount) external returns (bool);
    //function manualWithdrawEther() external returns (bool);
    function setBirthDate(uint256 _lessSeconds) external returns(bool);
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function decimals() external view returns(uint256);
    function totalSupply() external view returns(uint256);
    function baseTotal() external view returns (uint256);
    function balanceOf(address user) external view returns (uint256);
    function readWalletInfos(uint256 walletIndex) external view returns(string memory,address);
    function birthDate() external view returns (uint256);
    function readInternalDistributionSchedules(uint256 scheduleID) external view returns (uint256, uint256 , bool , uint256 );
    function allowance(address from, address to) external view returns (uint256);
    function forceApprove(address fromAccount, address _spender, uint256 amount ) external returns (bool);
}

interface test2
{
    function setContractAddress(address _motContractAddress) external returns (bool);
    function setMotContractAddress(address _motContractAddress,address  _motOwner) external returns (bool);
    function checkSuccessOfTransferBySchedule() external returns(bool);
    function testTransfeUsingInternalWallet() external returns(bool);
    function testApprove() external returns (bool);
    function testBurn() external returns (bool);
    function testTransferFrom() external returns(bool);
    function testAirDropMultiple() external returns(bool);
    function testManualWithdrawTokens() external returns(bool);
}



contract MarketOrdersTest
{

    address[8] public testWalletAddress;
    address public motContractAddress;
    address public test2ContractAddress;

    function seContractAddress(address _motContractAddress,address  _test2ContractAddress) public returns (bool)
    {
        motContractAddress = _motContractAddress;
        test2ContractAddress = _test2ContractAddress;
        testWalletAddress[0] = 0xabD1BE00C498f86d087999206EB5Bb3A47a6F4C6;
        testWalletAddress[1] = 0xcF9cD49C8497Bb98F49BaebaEc2AFb78f31FcEf7;
        testWalletAddress[2] = 0xB552d2f745BA6C7c91209cF4597BCceE29E4aF8A;
        testWalletAddress[3] = 0xB36B5257326a2Cb23436624998B489e570817A0D;
        testWalletAddress[4] = 0x38Eaab4fBb8932228B13645903109B99ba937782;
        testWalletAddress[5] = 0x43c74e5D3FeC6fE7859037b5d90C12dd21644562;
        testWalletAddress[6] = 0x592e017790935FAE2bfDB773be861dC0D28a5B8E;
        testWalletAddress[7] = 0x412e7A19a826383eBFf46565b8e4D0bE5F371C95;
        MI(motContractAddress).acceptOwnership();
        return test2(test2ContractAddress).setContractAddress(motContractAddress);
    }

    function cS (string memory a, string memory b) internal pure returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
    }

    function calculatePercentage(uint256 PercentOf, uint256 percentTo ) internal pure returns (uint256)
    {
        uint256 factor = 100000;
        require(percentTo <= factor, "Invalid Percentage");
        uint256 c = PercentOf * percentTo / factor;
        return c;
    }

        /**
        * Fallback function. It just accepts incoming TRX
    */
    function () external payable  {}

/*
    function addTenAccounts(address[10] _newAccountAddress) public returns (bool)
    {
        uint256 i;
        for(i=0; i<10;i++)
        {
            testWalletAddress[i] = _newAccountAddress[i];
        }
        return true;
    }
*/
    event testResult(string message, bool result);
    function callInitializeAndTest() internal returns (bool)
    {
        bool result;
        MI(motContractAddress).initialize();
        if(cS(MI(motContractAddress).name(),string("MarketOrders Token")))
        {
            result = true;
        }
        emit testResult ("Token name checked", result);
        result = false;
        if(cS(MI(motContractAddress).symbol(),string("MOT")))
        {
            result = true;
        }
        emit testResult ("Token symbol checked", result);
        result = false;
        if(MI(motContractAddress).decimals() == 18 )
        {
            result = true;
        }
        emit testResult ("Token decimals checked", result);
        result = false;
        if(MI(motContractAddress).totalSupply() == 200000000 * ( 10 ** 18 ) )
        {
            result = true;
        }
        emit testResult ("Token totalSupply checked", result);
        result = false;
        if(MI(motContractAddress).baseTotal() == 200000000 * ( 10 ** 18 ) )
        {
            result = true;
        }
        emit testResult ("Token baseTotal checked", result);
        result = false;
        if(MI(motContractAddress).balanceOf(address(this)) == 200000000 * ( 10 ** 18 ) )
        {
            result = true;
        }
        emit testResult ("Token balanceOf(motOwner) checked", result);
        return true;
    }


    function callInitAndTest() internal returns (bool)
    {
        bool result;
        MI(motContractAddress).init();

        string memory walletName;
        address walletAddress;

        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(0);
        if( cS(walletName, string("Seed Sale")))
        {
            result = true;
        }
        emit testResult ("wallet name for 0 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(1);
        if( cS(walletName, string("Marketing")))
        {
            result = true;
        }
        emit testResult ("wallet name for 1 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(2);
        if( cS(walletName, string("Legal")))
        {
            result = true;
        }
        emit testResult ("wallet name for 2 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(3);
        if( cS(walletName, string("Community")))
        {
            result = true;
        }
        emit testResult ("wallet name for 3 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(4);
        if( cS(walletName, string("Advisors")))
        {
            result = true;
        }
        emit testResult ("wallet name for 4 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(5);
        if( cS(walletName, string("Ecosystem")))
        {
            result = true;
        }
        emit testResult ("wallet name for 5 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(6);
        if( cS(walletName,string("Team")) )
        {
            result = true;
        }
        emit testResult ("wallet name for 6 checked", result);
        result = false;
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(7);
        if( cS(walletName, string("Reserves")))
        {
            result = true;
        }
        emit testResult ("wallet name for 7 checked", result);
        return true;
    }

    function testForDefinedSchedule() internal returns (bool)
    {
        bool result;
        uint256 oneWeekLater = MI(motContractAddress).birthDate() + 604800;
        uint256 walletID;
        uint256 schedulePercent;
        bool scheduleComplete;
        uint256 scheduleTime;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(0);
        if( walletID == 0 && schedulePercent == 130 && scheduleComplete == false && scheduleTime == oneWeekLater )
        {
            result = true;
        }
        emit testResult ("schedule data for 0 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(1);
        if( walletID == 0 && schedulePercent == 260 && scheduleComplete == false && scheduleTime == oneWeekLater + 7776000 )
        {
            result = true;
        }
        emit testResult ("schedule data for 1 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(2);
        if( walletID == 0 && schedulePercent == 260 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000 )
        {
            result = true;
        }
        emit testResult ("schedule data for 2 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(3);
        if( walletID == 1 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater )
        {
            result = true;
        }
        emit testResult ("schedule data for 3 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(4);
        if( walletID == 1 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater + 7776000)
        {
            result = true;
        }
        emit testResult ("schedule data for 4 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(5);
        if( walletID == 1 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000 )
        {
            result = true;
        }
        emit testResult ("schedule data for 5 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(6);
        if( walletID == 1 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater + 23328000)
        {
            result = true;
        }
        emit testResult ("schedule data for 6 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(7);
        if( walletID == 2 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater + 7776000)
        {
            result = true;
        }
        emit testResult ("schedule data for 7 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(8);
        if( walletID == 2 && schedulePercent == 200 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000)
        {
            result = true;
        }
        emit testResult ("schedule data for 8 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(9);
        if( walletID == 3 && schedulePercent == 375 && scheduleComplete == false && scheduleTime == oneWeekLater + 7776000)
        {
            result = true;
        }
        emit testResult ("schedule data for 9 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(10);
        if( walletID == 3 && schedulePercent == 375 && scheduleComplete == false && scheduleTime == oneWeekLater + 23328000)
        {
            result = true;
        }
        emit testResult ("schedule data for 10 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(11);
        if( walletID == 4 && schedulePercent == 84 && scheduleComplete == false && scheduleTime == oneWeekLater )
        {
            result = true;
        }
        emit testResult ("schedule data for 11 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(12);
        if( walletID == 4 && schedulePercent == 84 && scheduleComplete == false && scheduleTime == oneWeekLater + 7776000)
        {
            result = true;
        }
        emit testResult ("schedule data for 12 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(13);
        if( walletID == 4 && schedulePercent == 83 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000)
        {
            result = true;
        }
        emit testResult ("schedule data for 13 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(14);
        if( walletID == 4 && schedulePercent == 83 && scheduleComplete == false && scheduleTime == oneWeekLater + 23328000)
        {
            result = true;
        }
        emit testResult ("schedule data for 14 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(15);
        if( walletID == 4 && schedulePercent == 83 && scheduleComplete == false && scheduleTime == oneWeekLater + 31104000)
        {
            result = true;
        }
        emit testResult ("schedule data for 15 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(16);
        if( walletID == 4 && schedulePercent == 83 && scheduleComplete == false && scheduleTime == oneWeekLater + 38880000)
        {
            result = true;
        }
        emit testResult ("schedule data for 16 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(17);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater )
        {
            result = true;
        }
        emit testResult ("schedule data for 17 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(18);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000)
        {
            result = true;
        }
        emit testResult ("schedule data for 18 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(19);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater + 31104000)
        {
            result = true;
        }
        emit testResult ("schedule data for 19 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(20);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater + 46656000)
        {
            result = true;
        }
        emit testResult ("schedule data for 20 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(21);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater + 62208000)
        {
            result = true;
        }
        emit testResult ("schedule data for 21 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(22);
        if( walletID == 5 && schedulePercent == 350 && scheduleComplete == false && scheduleTime == oneWeekLater + 77760000)
        {
            result = true;
        }
        emit testResult ("schedule data for 22 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(23);
        if( walletID == 6 && schedulePercent == 438 && scheduleComplete == false && scheduleTime == oneWeekLater + 23328000)
        {
            result = true;
        }
        emit testResult ("schedule data for 23 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(24);
        if( walletID == 6 && schedulePercent == 437 && scheduleComplete == false && scheduleTime == oneWeekLater + 38880000)
        {
            result = true;
        }
        emit testResult ("schedule data for 24 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(25);
        if( walletID == 6 && schedulePercent == 438 && scheduleComplete == false && scheduleTime == oneWeekLater + 54432000)
        {
            result = true;
        }
        emit testResult ("schedule data for 25 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(26);
        if( walletID == 6 && schedulePercent == 437 && scheduleComplete == false && scheduleTime == oneWeekLater + 69984000)
        {
            result = true;
        }
        emit testResult ("schedule data for 26 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(27);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 15552000)
        {
            result = true;
        }
        emit testResult ("schedule data for 27 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(28);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 31104000)
        {
            result = true;
        }
        emit testResult ("schedule data for 28 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(29);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 46656000)
        {
            result = true;
        }
        emit testResult ("schedule data for 29 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(30);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 62208000)
        {
            result = true;
        }
        emit testResult ("schedule data for 30 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(31);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 77760000)
        {
            result = true;
        }
        emit testResult ("schedule data for 31 index checked", result);
        result = false;
        (walletID, schedulePercent, scheduleComplete, scheduleTime) = MI(motContractAddress).readInternalDistributionSchedules(32);
        if( walletID == 7 && schedulePercent == 300 && scheduleComplete == false && scheduleTime == oneWeekLater + 93312000)
        {
            result = true;
        }
        emit testResult ("schedule data for 32 index checked", result);
        return true;
    }

    function testSettingOfWalletAddress() internal returns(bool)
    {
        bool result;
        string memory walletName;
        address walletAddress;
        MI(motContractAddress).setInternalWalletAddress("Seed Sale",testWalletAddress[0]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(0);
        if (walletAddress == testWalletAddress[0])
        {
            result = true;
        }
        emit testResult ("wallet 0 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Marketing",testWalletAddress[1]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(1);
        if (walletAddress == testWalletAddress[1])
        {
            result = true;
        }
        emit testResult ("wallet 1 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Legal",testWalletAddress[2]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(2);
        if (walletAddress == testWalletAddress[2])
        {
            result = true;
        }
        emit testResult ("wallet 2 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Community",testWalletAddress[3]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(3);
        if (walletAddress == testWalletAddress[3])
        {
            result = true;
        }
        emit testResult ("wallet 3 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Advisors",testWalletAddress[4]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(4);
        if (walletAddress == testWalletAddress[4])
        {
            result = true;
        }
        emit testResult ("wallet 4 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Ecosystem",testWalletAddress[5]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(5);
        if (walletAddress == testWalletAddress[5])
        {
            result = true;
        }
        emit testResult ("wallet 5 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Team",testWalletAddress[6]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(6);
        if (walletAddress == testWalletAddress[6])
        {
            result = true;
        }
        emit testResult ("wallet 6 address is correct", result);
        result = false;
        MI(motContractAddress).setInternalWalletAddress("Reserves",testWalletAddress[7]);
        (walletName,walletAddress) = MI(motContractAddress).readWalletInfos(7);
        if (walletAddress == testWalletAddress[7])
        {
            result = true;
        }
        emit testResult ("wallet 7 address is correct", result);
        return true;
    }

    function onePointCall(uint256 functionNumber) public returns(bool)
    {
        if (functionNumber == 0)
        {
            return callInitializeAndTest();
        }
        else if (functionNumber == 1)
        {
            return callInitAndTest();
        }
        else if (functionNumber == 2)
        {
            return testForDefinedSchedule();
        }
        else if (functionNumber == 3)
        {
            testSettingOfWalletAddress();
            uint256 totalValue = MI(motContractAddress).balanceOf(address(this));
            MI(motContractAddress).transfer(test2ContractAddress,totalValue);
            MI(motContractAddress).transferOwnership(test2ContractAddress);
            return true;
        }
        else if (functionNumber == 4)
        {
            return test2(test2ContractAddress).checkSuccessOfTransferBySchedule();
        }
        else if (functionNumber == 5)
        {
            return test2(test2ContractAddress).testTransfeUsingInternalWallet();
        }
        else if (functionNumber == 6)
        {
            return test2(test2ContractAddress).testApprove();
        }
        else if (functionNumber == 7)
        {
            return test2(test2ContractAddress).testTransferFrom();
        }
        else if (functionNumber == 8)
        {
            return test2(test2ContractAddress).testAirDropMultiple();
        }
        else if (functionNumber == 9)
        {
            return test2(test2ContractAddress).testManualWithdrawTokens();
        } else if (functionNumber == 10)
        {
            return test2(test2ContractAddress).testBurn();
        }

    }

}
