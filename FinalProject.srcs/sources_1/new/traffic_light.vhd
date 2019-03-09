----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 10:28:18 PM
-- Design Name: 
-- Module Name: traffic_light - Behavioral
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

entity traffic_light is
    Port ( clock : in STD_LOGIC;
           resetn: in STD_LOGIC; 
           lights : out STD_LOGIC_VECTOR (5 downto 0));
end traffic_light;

architecture Behavioral of traffic_light is
    
    component my_5_modulus_ctr
        port ( clock : in STD_LOGIC;
           resetn : in STD_LOGIC;
           E : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0);
           z : out STD_LOGIC);
    end component;
    
    component my_5bit_down_load_ctr
        port ( clock : in STD_LOGIC;
           set : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (4 downto 0);
           resetn : in STD_LOGIC;
           E : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (4 downto 0);
           z : out STD_LOGIC);
     end component;
     
     component my_100M_modulus_ctr
        port ( clock : in STD_LOGIC;
               resetn : in STD_LOGIC;
               E : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (31 downto 0);
               z : out STD_LOGIC);
     end component;
     
     signal one_sec_clock: STD_LOGIC;
     signal time_next: STD_LOGIC_VECTOR (4 downto 0);
     signal load_next: STD_LOGIC;
     signal stage: STD_LOGIC_VECTOR (2 downto 0);
     signal ctr_0_enable: STD_LOGIC;
     signal ctr_1_enable: STD_LOGIC;
     signal ctr_2_enable: STD_LOGIC;
     
begin
   --Down clocks the 100MHz clock to 1Hz 
   ctr_0: my_100M_modulus_ctr port map( clock => clock, 
                                        resetn => resetn,
                                        E => ctr_0_enable,
                                        z => one_sec_clock); --For Test bench unmap this signal
                                        

   --Counts down the time for each cycle 
   ctr_1: my_5bit_down_load_ctr port map(   clock => one_sec_clock, 
                                            z => load_next, 
                                            set => load_next, 
                                            data => time_next,
                                            resetn => resetn,
                                            E => ctr_1_enable); 
   
   --Loops through the light cycle "stages" 
   ctr_2: my_5_modulus_ctr port map(    clock => load_next, 
                                        E => ctr_2_enable,
                                        resetn => resetn,
                                        Q => stage);
                                        
    --I guess just enable everything all the time?                    
    ctr_0_enable <= '1';
    ctr_1_enable <= '1';
    ctr_2_enable <= '1';
    
    --For DEBUG / Testing purposes. Test bench will simulate 1 second clock.
    --this will be replaced with implementation of ctr_0
    --one_sec_clock <= clock;
     
    --LUT Time this is the time that is loaded for the following stage. Not! the current stage.                                   
    with stage select
        time_next <= "01010" when "000", -- 10 seconds
                     "00011" when "001", -- 3 seconds
                     "00001" when "010", -- 1 seconds 
                     "01010" when "011", 
                     "00011" when "100", 
                     "00001" when "101", 
                     "00001" when others;
     
     --LUT Output                
     with resetn&stage select
        lights <=    "001100" when "1000", --10 seconds stage 0
                     "010100" when "1001", --2 seconds stage 1
                     "100100" when "1010", --1 seconds stage 2
                     "100001" when "1011", --10 seconds stage 3
                     "100010" when "1100", --2 seconds stage 4
                     "100100" when "1101", --1 seconds stage 5
                     "000000" when others; --Yellow/Yellow for undefined state I guess?
        
                  
                                        

end Behavioral;
