library ieee;
use ieee.std_logic_1164.all;
--USE ieee.numeric_std.ALL;

entity TX_tb is
end TX_tb;

architecture behavior of TX_tb is

   -- Component Declaration for the Unit Under Test (UUT)

   component TX
      port (
         tx_q : out STD_LOGIC;
         tx_done : out STD_LOGIC;
         tx_start : in STD_LOGIC;
         tx_data : in STD_LOGIC_VECTOR(7 downto 0);
         clk : in STD_LOGIC;
         reset : in STD_LOGIC
      );
   end component;
   --Inputs
   signal tx_start : STD_LOGIC := '0';
   signal tx_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal clk : STD_LOGIC := '0';
   signal reset : STD_LOGIC := '0';

   --Outputs
   signal tx_q : STD_LOGIC;
   signal tx_done : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : TIME := 10 ns;

begin

   -- Instantiate the Unit Under Test (UUT)
   uut : TX port map(
      tx_q => tx_q,
      tx_done => tx_done,
      tx_start => tx_start,
      tx_data => tx_data,
      clk => clk,
      reset => reset
   );

   -- Clock process definitions
   clk_process : process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
   -- Stimulus process
   stim_proc : process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      --wait for clk_period*10;
      tx_data <= "00101011";
      tx_start <= '1';
      wait for 100 ns;
      tx_start <= '0';

      -- insert stimulus here 

      wait;
   end process;

end;