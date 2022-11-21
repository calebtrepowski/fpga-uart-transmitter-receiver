library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RX is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        rx_data : in STD_LOGIC;
        tx_q : out STD_LOGIC_VECTOR (7 downto 0);
        tx_available : out STD_LOGIC);
end RX;

architecture Behavioral of RX is

begin
end Behavioral;