----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Scott Agnolutto
-- 
-- Create Date:    10:33:47 07/07/2012 
-- Design Name: 	Mealy Elevator Controller
-- Module Name:    MealyElevatorController_Agnolutto - Behavioral 
-- Project Name: CE3
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity MealyElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end MealyElevatorController_Shell;

architecture Behavioral of MealyElevatorController_Shell is

type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state : floor_state_type;

begin

floor_state_machine: process(clk)
begin


if clk'event and clk='1' then
	--mealy machine so this part is different from the moore
	if reset='1' then
		floor_state <=floor1;
		
	else
	----these floor state cases are the same from the moore state machine
	--pretty self explanatory
	--if on a given floor and indicated going up with stop='0' then go to the next floor, vice verse
	--for going down a floor, and add the else statement that keeps the floor the same because the 
	--elevator is not changing floors
		case floor_state is

				when floor1 =>
					if (up_down='1' and stop='0') then 

						floor_state <= floor2;

					else
						floor_state <= floor1;
					end if;
	
				when floor2 => 
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			

					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
		
					else
						floor_state <= floor2;
					end if;
			
				when floor3 =>
					if (up_down='1' and stop ='0') then 
						floor_state <= floor4;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;	
					else
						floor_state <= floor3;	
					end if;
					
				when floor4 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else 
						floor_state <= floor4;
					end if;
				
				--This line accounts for phantom states
				when others =>
					floor_state <= floor1;
		end case;
	end if;	
	end if;
		

end process;

------------------------------------------------
--output
------------------------------------------------
--outputs what floor you are on in correlation with the correct floor state
floor <= "0001" when (floor_state = floor1) else
			"0010" when ( floor_state = floor2) else
			"0011" when ( floor_state = floor3) else
			"0100" when ( floor_state = floor4) else
			"0001";
			
--accounts for staying on top and bottom floor as well as moving up and down
nextfloor <=	"0010" when (floor_state = floor1 and up_down = '1') else
			"0010" when (floor_state = floor3 and up_down = '0') else
			"0001" when (floor_state = floor2 and up_down = '0') else
			"0011" when (floor_state = floor2) else
			"0100" when (floor_state = floor3) else
			"0100" when (floor_state = floor4 and up_down = '1') else
			"0011" when (floor_state = floor4) else
			"0001";	

end Behavioral;

