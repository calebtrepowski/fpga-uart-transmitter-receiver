library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RX is
    port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        rx_data : in STD_LOGIC;
        rx_q : out STD_LOGIC_VECTOR (7 downto 0);
        rx_available : out STD_LOGIC);
end RX;

architecture Behavioral of RX is
    -- FPGA clock frequency/baud rate frequency
    -- for 9600 bps: 100M/9600
    constant BPS_CLOCK_COUNT : INTEGER := 10416;
    -- for oversampling method
    constant HALF_BPS_CLOCK_COUNT : INTEGER := 5208;

    -- substract one
    constant DATA_BITS : INTEGER := 7;

    type state_type is (
        st1_idle,
        st2_start,
        st3_count,
        st4_shift,
        st5_stop
    );
    signal rx_state, rx_next_state : state_type;

    signal rx_shift_register : STD_LOGIC_VECTOR(7 downto 0);
    signal rx_shift_register_clear : STD_LOGIC;
    signal rx_shift_register_shift : STD_LOGIC;
    signal rx_shift_register_keep : STD_LOGIC;

begin

    rx_shift_register_process : process (
        clk,
        rx_shift_register_clear,
        rx_shift_register_shift,
        rx_shift_register_keep
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '1' or rx_shift_register_clear = '1' then
                rx_shift_register <= (others => '0');
            elsif rx_shift_register_shift = '1' then
                rx_shift_register <= rx_data & rx_shift_register(7 downto 1);
            elsif rx_shift_register_keep = '1' then
                rx_shift_register <= rx_shift_register;
            end if;
        end if;
    end process rx_shift_register_process;

    rx_q <= rx_shift_register;
    -- debug purposes
    rx_shift_register_clear <= '0';
    rx_shift_register_shift <= '1';
    rx_shift_register_keep <= '0';
end Behavioral;