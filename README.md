ECE281_Lab3
===========
### Pre Lab Schematic
![prelab] (https://raw.github.com/C15Agnolutto/ECE281_Lab3/master/prelab3_schematic.JPG)


### Basic Elevator Controller - Moore
Didn't run into too much trouble with this. Already had the code from the CE3 so just had to link it to my top shell. 
Added the component and instantiation declaration for it. All I changed after that was nibble0 to my assigned variable
that links my output of the moore machine to the top shell which was El_floor. That can all be seen and commented in 
the provided files. The testing for it had no errors and worked on the first try.

### Mealy Elevator Controller
Okay so I apparently did this wrong for my CE3. My next_floor outputs were slightly messed up. On the first and fourth 
floors, the next floor state was supposed to match the current floor unless the up_down switch was indicating it was going 
to move to another floor. So I fixed that by altering my outputs for my next_floor. Pretty easy fix. Then I followed
the same regiment as I did for the moore machine. I added my component and instantiation declaration for it. The big change
was assigning nibble1 to El_nextfloor which was linked to my output for the mealy machine. Had to test it twice because 
I still messed up one of the outputs for it; I had it in the wrong order so the next floor for the first floor was still
wrong. Fixed that problem and it tested correctly.

### Prime Numbers 
Okay so first thought was that I would be able to use a single output to go through floors 2,3,5,7,11,13,17,19. Tried 
making it an 8 bit output but ran into problems when trying to get the output to link to my nibbles. So backtracked.
By the way, I used the same .vhd file from the basic moore controller but just commented out the other code. I added the 
addition cases to my code; so I had eight floors. No problem there, pretty easy. Took me awhile to figure out how to 
assign my outputs. Decided to use two output variables, one would hold the singles-digit and the other the tens-digit. 
This simplified the issue. Altered my component and instatiation declarations and added the appropriate signals which was 
a simple std_logic_vector(3 downto 0). Nibble0 was set for floorA (the singles-digit) and nibble1 was set for floorB (the
tens-digit). Testing this and surprisingly got it to work on the first program cycle. No other problems here.

### Changed Input 
So my idea here was just have 3 switches control what floor the elevator will move to. The 3 switches are linked to a 3 bit
binary number called changed_inputs. Created a new file for this one because it was substantially different. The cases 
were the same idea except instead of up_down and stop, I used straight binary like 000 or 001. That part was not 
a problem; I used the same technique for all eight cases. The output was the same as the basic moore machine except 
I coded for all eight floors. Not bad. To implement this to the top shell, I simply coded out the items in the componet
and instantiation declaration that was for the other functionalities, and replaced them with the appropriate variables
from the new changed input moore machine file.I only used nibble0 and it was assigned to El_floor, all others were set to
zero. Testing went smooth. Toggling the three switches to go to the floor you wanted worked fine and it didn't jump
from floor4 to floor2 or anything weird that might've occured because I used a 3 bit binary system to indicate the floor.



### Code Critique of the CE3 Moore Machine Shell

#Bad Code
`if clk'event and clk='1' then`

Not necessarily wrong but it can be done more efficently shown below.

#Good Code
`if (rising_edge(clk))then`

The book shows it like this frequently. It is just easier to understand what is happening.


#Bad Code
`when floor3 =>`
                   ` if (                            ) then `
                       ` floor_state <= `
                   ` elsif (                     ) then `
                   `     floor_state <=  `
                  `  else`
                  `      floor_state <=  `
                `    end if;`
             `   when floor4 =>`
                `    if (                            ) then `
                  `      floor_state <=  `
                  `  else `
                  `      floor_state <=  `
                  `  end if;`

This bad because it is blank. Although this was done on purpose, it still doesn't complile in this format.

#Good Code
`				when floor3 =>`
				`	if (up_down='1' and stop ='0') then `
				`		floor_state <= floor4;`
			`		elsif (up_down='0' and stop='0') then `
			`			floor_state <= floor2;	`
			`		else`
			`			floor_state <= floor3;	`
			`		end if;`
			
This is good because it has been filled in correctly. The code now compiles and works as anticpated.


#Bad Code
`floor <= "0001" when (floor_state =       ) else`
          `  "0010" when (                    ) else`
          `  "0011" when (                    ) else`
          `  "0100" when (                    ) else`
          `  "0001";`
          
This code is bad because again it is blank. It does not compile in this state.

#Good Code
`floor <= "0001" when (floor_state = floor1) else`
		`	"0010" when ( floor_state = floor2) else`
		`	"0011" when ( floor_state = floor3) else`
		`	"0100" when ( floor_state = floor4) else`
		`	"0001";`
		
This code is good because it is filled in correctly, and it now compiles.


#Bad Code
`floor_state_machine: process(clk)`

This is bad because this could possible generate memory which is bad in a Moore machine.

`floor_state_machine: process(clk,reset, floor_state)`

This is good because this is stop any possible memory from forming. 













