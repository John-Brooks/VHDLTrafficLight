----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 10:36:18 PM
-- Design Name: 
-- Module Name: my_5_modulus_ctr - Behavioral
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

entity my_5_modulus_ctr is
    Port ( clock : in STD_LOGIC;
           resetn : in STD_LOGIC;
           E : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0);
           z : out STD_LOGIC);
end my_5_modulus_ctr;

architecture Behavioral of my_5_modulus_ctr is
 signal Qt: integer range 0 to 5;
begin
    process (resetn, clock, E)
	begin
		if resetn = '0' then
			Qt <= 0;
		elsif (clock'event and clock = '1') then
			if E = '1' then
				if Qt = 5 then
					Qt <= 0;
				else
					Qt <= Qt + 1;
				end if;
			end if;
		end if;
	end process;
	Q <= conv_std_logic_vector(Qt,3);

	z <= '1' when Qt = 12 else '0';
end Behavioral;
