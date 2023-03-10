library ieee;
use ieee.std_logic_1164.all;
--USE ieee.numeric_std.ALL;

entity RX_tb is
end RX_tb;

architecture behavior of RX_tb is

   -- Component Declaration for the Unit Under Test (UUT)

   component RX
      port (
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         rx_data : in STD_LOGIC;
         rx_q : out STD_LOGIC_VECTOR(7 downto 0);
         rx_available : out STD_LOGIC
      );
   end component;
   --Inputs
   signal clk : STD_LOGIC := '0';
   signal reset : STD_LOGIC := '0';
   signal rx_data : STD_LOGIC := '0';

   --Outputs
   signal rx_q : STD_LOGIC_VECTOR(7 downto 0);
   signal rx_available : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : TIME := 10 ns;

   signal data_word : STD_LOGIC_VECTOR(7 downto 0) := "00110101";

begin

   -- Instantiate the Unit Under Test (UUT)
   uut : RX port map(
      clk => clk,
      reset => reset,
      rx_data => rx_data,
      rx_q => rx_q,
      rx_available => rx_available
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

      wait for clk_period * 10;

      -- insert stimulus here 
      reset <= '0';
      rx_data <= '1';
      wait for 10 ns;
      reset <= '1';
      wait for 30 ns;
      -- start bit
      rx_data <= '0';
      wait for 80 ns;

      -- data bits
      rx_data <= data_word(0);
      wait for 80 ns;
      rx_data <= data_word(1);
      wait for 80 ns;
      rx_data <= data_word(2);
      wait for 80 ns;
      rx_data <= data_word(3);
      wait for 80 ns;
      rx_data <= data_word(4);
      wait for 80 ns;
      rx_data <= data_word(5);
      wait for 80 ns;
      rx_data <= data_word(6);
      wait for 80 ns;
      rx_data <= data_word(7);
      wait for 80 ns;
      
      -- stop bit
      rx_data <= '1';

      wait;
   end process;

end;