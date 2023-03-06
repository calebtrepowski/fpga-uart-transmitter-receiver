library ieee;
use ieee.std_logic_1164.all;
--USE ieee.numeric_std.ALL;

entity uart_tx_rx_tb is
end uart_tx_rx_tb;

architecture behavior of uart_tx_rx_tb is

   -- Component Declaration for the Unit Under Test (UUT)

   component uart_tx_rx
      port (
         clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         tx_start : in STD_LOGIC;
         tx_data : in STD_LOGIC_VECTOR(7 downto 0);
         tx_q : out STD_LOGIC;
         tx_done : out STD_LOGIC;
         rx_data : in STD_LOGIC;
         rx_q : out STD_LOGIC_VECTOR(7 downto 0);
         rx_available : out STD_LOGIC
      );
   end component;
   --Inputs
   signal clk : STD_LOGIC := '0';
   signal reset : STD_LOGIC := '0';
   signal tx_start : STD_LOGIC := '0';
   signal tx_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal rx_data : STD_LOGIC := '0';

   --Outputs
   signal tx_q : STD_LOGIC;
   signal tx_done : STD_LOGIC;
   signal rx_q : STD_LOGIC_VECTOR(7 downto 0);
   signal rx_available : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : TIME := 10 ns;

   -- for testing rx
   signal data_word : STD_LOGIC_VECTOR(7 downto 0) := "00110101";
begin

   -- Instantiate the Unit Under Test (UUT)
   uut : uart_tx_rx port map(
      clk => clk,
      reset => reset,
      tx_start => tx_start,
      tx_data => tx_data,
      tx_q => tx_q,
      tx_done => tx_done,
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
      reset <= '1';
      rx_data <= '1';
      wait for 10 ns;
      reset <= '0';
      wait for 30 ns;
      tx_data <= "00101011";
      tx_start <= '1';
      wait for 100 ns;
      tx_start <= '0';
      wait for 200 ns;
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