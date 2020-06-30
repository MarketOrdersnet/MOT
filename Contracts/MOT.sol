/**
 *Submitted for verification at Etherscan.io on 2019-12-16
*/

/**
* Copyright MARKETORDERS 2019
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
    => airdrop function
    => internal administrative wallet
    => Scheduled fund allocation control

======================= Quick Stats ===================
    => Name        : MARKETORDERS TOKEN
    => Symbol      : MOT
    => Total supply: 200,000,000 (200 Million)
    => Decimals    : 18

-------------------------------------------------------------------------------------------------
 Copyright (c) 2019 onwards MARKETORDERS LTD ( https://MarketOrders.net , https://MarketOrders.io)
 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-------------------------------------------------------------------------------------------------
*/
 
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
    uint256 public birthDate; // The date of contract deploy
	bool public initialized = false;
	bool public inited = false;

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

    function cS (string memory a, string memory b) public pure returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

     /**
     * Constructor function just assigns initial supply to Owner
     */

    function initialize() public initializer {
		require(initialized == false, "already initialized");
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

		initialized = true;

        //firing event which logs this transaction
        emit Transfer(address(0), owner, totalSupply);
    }

    function init() public onlyOwner returns (bool) {
		require(inited == false, "already inited");
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

		inited = true;

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
    function airDropMultiple(address[] memory recipients,uint[] memory tokenAmount) public returns (bool) {
        uint reciversLength = recipients.length;

        require(reciversLength <= 150, "Too many address");
        for(uint i = 0; i < reciversLength; i++)
        {
            _airDrop(msg.sender, recipients[i],tokenAmount[i]);
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

}