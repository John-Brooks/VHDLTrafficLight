----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 10:33:08 PM
-- Design Name: 
-- Module Name: my_100M_modulus_ctr - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_arith.all;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity my_100M_modulus_ctr is
--    Port ( clock : in STD_LOGIC;
--           resetn : in STD_LOGIC;
--           E : in STD_LOGIC;
--           Q : out STD_LOGIC_VECTOR (31 downto 0);
--           z : out STD_LOGIC);
--end my_100M_modulus_ctr;

--architecture Behavioral of my_100M_modulus_ctr is
--    signal Qt: integer range 0 to 10; --100000000
--begin
--    process (resetn, clock, E)
--	begin
--		if resetn = '0' then
--			Qt <= 0;
--		elsif (clock'event and clock = '1') then
--			if E = '1' then
--				if Qt >= 10 then --100000000
--					Qt <= 0;
--				else
--					Qt <= Qt + 1;
--				end if;
--			end if;
--		end if;
--	end process;
--	Q <= conv_std_logic_vector(Qt,32);

--	z <= '0' when Qt < 5 else '1'; --50000000


--end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity my_100M_modulus_ctr is
	generic (COUNT: INTEGER:= (10**8)); -- (10**8)/2 cycles of T = 10 ns --> 0.5 s
	--generic (COUNT: INTEGER:= (10**2)); -- (10**2)/2 cycles of T = 10 ns --> 0.5us
	port (clock, resetn, E: in std_logic;
			Q: out std_logic_vector ( integer(ceil(log2(real(COUNT)))) - 1 downto 0);
			z: out std_logic);
end my_100M_modulus_ctr;

architecture Behavioral of my_100M_modulus_ctr is
	constant nbits: INTEGER:= integer(ceil(log2(real(COUNT))));
	signal Qt: std_logic_vector (nbits -1 downto 0);
begin

	process (resetn, clock)
	begin
		if resetn = '0' then
			Qt <= (others => '0');
		elsif (clock'event and clock = '1') then
			if E = '1' then
                if Qt = conv_std_logic_vector (COUNT-1,nbits) then
                    Qt <= (others => '0');
                    z <= '1';
                else
                    Qt <= Qt + conv_std_logic_vector (1,nbits);
                    z <= '0';
                end if;
			end if;
		end if;
	end process;
	
	--z <= '1' when Qt = conv_std_logic_vector (COUNT-1,nbits) else '0';
   Q <= Qt;
	
end Behavioral;