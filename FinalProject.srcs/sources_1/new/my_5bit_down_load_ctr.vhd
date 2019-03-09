----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 10:42:53 PM
-- Design Name: 
-- Module Name: my_5bit_down_load_ctr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_5bit_down_load_ctr is
    Port ( clock : in STD_LOGIC;
           set : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (4 downto 0);
           resetn : in STD_LOGIC;
           E : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (4 downto 0);
           z : out STD_LOGIC);
end my_5bit_down_load_ctr;

architecture Behavioral of my_5bit_down_load_ctr is
    signal Qt: integer range 0 to 31;
begin
    process (resetn, clock, E)
	begin
		if resetn = '0' then
			Qt <= 0;
		elsif (clock'event and clock = '1') then
			if E = '1' then
			    if set = '1' then
			        Qt <= CONV_INTEGER(unsigned(data));
				elsif Qt > 0 then
					Qt <= Qt - 1;
				end if;
			end if;
		end if;
	end process;
	Q <= conv_std_logic_vector(Qt,5);

	z <= '1' when Qt = 0 else '0';

end Behavioral;
