library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.NUMERIC_STD.ALL;

entity uart_tx_rx is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        tx_start : in STD_LOGIC;
        tx_data : in STD_LOGIC_VECTOR (7 downto 0);
        tx_q : out STD_LOGIC;
        tx_done : out STD_LOGIC;
        rx_data : in STD_LOGIC;
        rx_q : out STD_LOGIC_VECTOR (7 downto 0);
        rx_available : out STD_LOGIC);
end uart_tx_rx;

architecture Behavioral of uart_tx_rx is
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

    component RX
        port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            rx_data : in STD_LOGIC;
            rx_q : out STD_LOGIC_VECTOR(7 downto 0);
            rx_available : out STD_LOGIC
        );
    end component;
begin
    tx_unit : TX port map(
        tx_q => tx_q,
        tx_done => tx_done,
        tx_start => tx_start,
        tx_data => tx_data,
        clk => clk,
        reset => reset
    );
    rx_unit : RX port map(
        clk => clk,
        reset => reset,
        rx_data => rx_data,
        rx_q => rx_q,
        rx_available => rx_available
    );
end Behavioral;