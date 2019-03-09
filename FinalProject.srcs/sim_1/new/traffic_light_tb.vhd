----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 10:28:18 PM
-- Design Name: 
-- Module Name: traffic_light_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic_light_tb is
--  Port ( );
end traffic_light_tb;

architecture Behavioral of traffic_light_tb is
    component traffic_light
        port ( clock : in STD_LOGIC;
               resetn: in STD_LOGIC; 
               lights: out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    
    signal CLOCK: STD_LOGIC;
    signal RESET: STD_LOGIC;
    signal LIGHTS: STD_LOGIC_VECTOR (5 downto 0);

begin
    uut: traffic_light port map(clock => CLOCK, resetn => RESET, lights => LIGHTS);
    
   stim_proc: process
   begin	
        CLOCK <= '0';
        RESET <= '0';
        wait for 10 ns;
        RESET <= '1';  
        wait for 10 ns;
        L1: loop
            CLOCK <= '1';
            wait for 10ns;
            CLOCK <= '0';
            wait for 10ns; 
        end loop;
        wait;
    end process;

end Behavioral;
