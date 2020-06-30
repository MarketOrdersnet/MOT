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
//  1.  initialize                  To set token name,symbo, totalSupply etc jus after deploy
//  3.  init                        To defined internal wallets and starting ref date of contracts with transfer schedule set
//  4.  setInternalWalletAddress    To associate address to the internal wallet
//  5.  transferByMetricPlan        To transfer fund from internal wallet to desired address
//  6.  doScheduledTransfer         To transfer fund from totalSupply to internal walled on defined schedule
//  7.  transfer                    Standared ERC20 Transfer
//  8.  transferFrom                Standared ERC20 TransferFrom
//  9.  approve                     Helper function for TransferFrom to function
//  10. airDropMultiple             Standared airDropMultiple
//  11. manualWithdrawTokens        Manual withdraw tokens by admin
//  12. manualWithdrawEther         Manual withdraw ether by admin (It needs to pay ether then withdraw, so pls test it manually)

//  NOTE : mot contract contains codes for change basic date of contract (nammed as birthDate in contract)
//  Just for test purpose, the function "change birthDate" should be removed or commented on final deploy

interface MI   // Stands for mot interface
{
    function acceptOwnership() external returns (address);
    function initialize() external;
    function init() external returns (bool); //onlyOwner
    function setInternalWalletAddress(bytes32 _forWalletName, address _walletAddress) external returns (bool);
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




contract MarketOrdersTest2
{

    address[8] public testWalletAddress;
    address[6] public externalWallet;
    address public motContractAddress;
    function setContractAddress(address _motContractAddress) external returns (bool)
    {
        motContractAddress = _motContractAddress;
        testWalletAddress[0] = 0xabD1BE00C498f86d087999206EB5Bb3A47a6F4C6;
        testWalletAddress[1] = 0xcF9cD49C8497Bb98F49BaebaEc2AFb78f31FcEf7;
        testWalletAddress[2] = 0xB552d2f745BA6C7c91209cF4597BCceE29E4aF8A;
        testWalletAddress[3] = 0xB36B5257326a2Cb23436624998B489e570817A0D;
        testWalletAddress[4] = 0x38Eaab4fBb8932228B13645903109B99ba937782;
        testWalletAddress[5] = 0x43c74e5D3FeC6fE7859037b5d90C12dd21644562;
        testWalletAddress[6] = 0x592e017790935FAE2bfDB773be861dC0D28a5B8E;
        testWalletAddress[7] = 0x412e7A19a826383eBFf46565b8e4D0bE5F371C95;

        externalWallet[0] = 0x476620f683f14E0df6870d84A85C3AA6Cc2b0d0E;
        externalWallet[1] = 0x12Aed85027F551333e13930273a20f0c51439053;
        externalWallet[2] = 0x77Da176a128731cA2d5B91D98706E39ad3D54D92;
        externalWallet[3] = 0xa3456ca3930B92c270591Aa359B5133EA2A00560;
        externalWallet[4] = 0x133C7DCA5d9d59908646526FC102deb2E89809d0;
        externalWallet[5] = 0xb03326A0c97a5449D2d42c1917A93BEba57207b2;
    }

    function cS (string memory a, string memory b) internal view returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
    }

    function calculatePercentage(uint256 PercentOf, uint256 percentTo ) internal pure returns (uint256)
    {
        uint256 factor = 10000;
        require(percentTo <= factor, "Invalid Percentage");
        uint256 c = PercentOf * percentTo / factor;
        return c;
    }
/*
    function addTenAccounts(address[10] _newAccountAddress) external returns (bool)
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

    function checkSuccessOfTransferBySchedule() external returns(bool)
    {
        MI(motContractAddress).acceptOwnership();
        bool result;
        uint256 totalSupply = MI(motContractAddress).totalSupply();
        MI(motContractAddress).setBirthDate(604801);
        MI(motContractAddress).doScheduledTransfer();
        if (MI(motContractAddress).balanceOf(address(this)) == calculatePercentage(totalSupply, 9236))
        {
            result = true;
        }
        emit testResult ("balance is correct after schedule transfer after a week", result);
        result = false;
        if (MI(motContractAddress).balanceOf(testWalletAddress[0]) == calculatePercentage(totalSupply, 130))
        {
            result = true;
        }
        emit testResult ("balance is correct of wallet 0 after schedule transfer after a week", result);
        result = false;

        (,,bool scheduleComplete,) = MI(motContractAddress).readInternalDistributionSchedules(0);
        if ( scheduleComplete == true)
        {
            result = true;
        }
        emit testResult ("schedule 0 is correctly marked as true after schedule transfer ", result);
        result = false;

        MI(motContractAddress).setBirthDate(7776001);
        MI(motContractAddress).doScheduledTransfer();
        if (MI(motContractAddress).balanceOf(address(this)) == calculatePercentage(totalSupply, 8117))
        {
            result = true;
        }
        emit testResult ("balance is correct after schedule transfer after three months", result);
        result = false;

        if (MI(motContractAddress).balanceOf(testWalletAddress[0]) == calculatePercentage(totalSupply, 390))
        {
            result = true;
        }
        emit testResult ("balance is correct of wallet 0 after schedule transfer after 3 months", result);
        result = false;

        (,,scheduleComplete,) = MI(motContractAddress).readInternalDistributionSchedules(1);
        if ( scheduleComplete == true)
        {
            result = true;
        }
        emit testResult ("schedule 1 is correctly marked as true after schedule transfer ", result);
        result = false;

        return true;
    }


    function testTransfeUsingInternalWallet() external returns(bool)
    {
        bool result;
        uint256 bal1 = MI(motContractAddress).balanceOf(testWalletAddress[0]);
        uint256 bal2 = MI(motContractAddress).balanceOf(externalWallet[0]);
        MI(motContractAddress).transferByMetricPlan(testWalletAddress[0], externalWallet[0], 10**20);
        if(bal1 - (10**20) == MI(motContractAddress).balanceOf(testWalletAddress[0]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 0 (source) is correct after transfer", result);
        result = false;
        if(bal2 + (10**20) == MI(motContractAddress).balanceOf(externalWallet[0]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 7 (target) is correct after transfer", result);
        result = false;
        return true;
    }

    function testApprove() external returns (bool)
    {
        bool result;
        MI(motContractAddress).approve(testWalletAddress[6], 10**20);
        if ( MI(motContractAddress).allowance(address(this),testWalletAddress[6]) == 10 ** 20)
        {
            result = true;
        }
        emit testResult ("approval of amount for transferFrom is correct", result);
        result = false;
    }

    function testBurn() external returns (bool)
    {
        bool result;

        uint256 balBefore = MI(motContractAddress).balanceOf(address(this));
        uint256 totalSupplyBefore = MI(motContractAddress).totalSupply();
        MI(motContractAddress).burn(100**20);
        uint256 totalSupplyAfter = MI(motContractAddress).totalSupply();
        if(totalSupplyBefore - (10**20) == totalSupplyAfter)
        {
            result = true;
        }
        emit testResult ("totalSupply is correctly reduced after burn", result);
        result = false;
        uint256 balAfter = MI(motContractAddress).balanceOf(address(this));
        if(balBefore - (10**20) == balAfter)
        {
            result = true;
        }
        emit testResult ("balance for owner is correctly reduced after burn", result);
        result = false;
    }

    function testTransferFrom() external returns(bool)
    {
        bool result;
        MI(motContractAddress).forceApprove(externalWallet[0], address(this), 10**18);
        uint256 bal1 = MI(motContractAddress).balanceOf(externalWallet[0]);
        uint256 bal2 = MI(motContractAddress).balanceOf(externalWallet[1]);
        MI(motContractAddress).transferFrom(externalWallet[0],externalWallet[1], 10**18);
        if(bal1 - (10**18) == MI(motContractAddress).balanceOf(externalWallet[0]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 0 (source) is correct after transferFrom", result);
        result = false;
        if(bal2 + (10**18) == MI(motContractAddress).balanceOf(externalWallet[1]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 5 (target) is correct after transferFrom", result);
        result = false;
        return true;
    }

    function testAirDropMultiple() external returns(bool)
    {
        bool result;
        uint256 bal1 = MI(motContractAddress).balanceOf(externalWallet[2]);
        uint256 bal2 = MI(motContractAddress).balanceOf(externalWallet[3]);

        address[] memory recipients = new address[](2);
        uint[] memory tokenAmounts = new uint[](2);
        (recipients[0], recipients[1]) = (externalWallet[2], externalWallet[3]);
        (tokenAmounts[0], tokenAmounts[1]) = (10**18, 10**19);
        MI(motContractAddress).airDropMultiple(recipients, tokenAmounts);

        //MI(motContractAddress).airDropMultiple([testWalletAddress[4],testWalletAddress[3]],[10**18, 10**19]);
        if(bal1 + (10**18) == MI(motContractAddress).balanceOf(externalWallet[2]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 4 (source) is correct after airdrop multiple", result);
        result = false;
        if(bal2 + (10**19) == MI(motContractAddress).balanceOf(externalWallet[3]))
        {
            result = true;
        }
        emit testResult ("blance of wallet 3 (target) is correct after airdrop multiple", result);
        result = false;
        return true;
    }


    function testManualWithdrawTokens() external returns(bool)
    {
        bool result;
        MI(motContractAddress).transfer(motContractAddress,10**20);
        uint256 bal1 = MI(motContractAddress).balanceOf(motContractAddress);
        uint256 bal2 = MI(motContractAddress).balanceOf(address(this));
        MI(motContractAddress).manualWithdrawTokens(10**18);
        if(bal1 - (10**18) == MI(motContractAddress).balanceOf(motContractAddress))
        {
            result = true;
        }
        emit testResult ("blance of mot contract (source) is correct after manual withdraw token", result);
        result = false;
        if(bal2 + (10**18) == MI(motContractAddress).balanceOf(address(this)))
        {
            result = true;
        }
        emit testResult ("blance of test contract (target) is correct after manual withdraw token", result);
        result = false;
        return true;
    }

}