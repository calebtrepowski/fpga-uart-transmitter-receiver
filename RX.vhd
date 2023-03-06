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
    -- debug
    -- constant BPS_CLOCK_COUNT : INTEGER := 6;

    -- for oversampling method
    -- must be BPS_CLOCK_COUNT/2
    -- constant HALF_BPS_CLOCK_COUNT : INTEGER := 5208;
    -- debug
    constant HALF_BPS_CLOCK_COUNT : INTEGER := 3;

    constant DATA_WORD_LENGTH : INTEGER := 8;
    constant DATA_BITS : INTEGER := DATA_WORD_LENGTH - 1;

    type state_type is (
        st1_idle,
        st2_start,
        st3_count,
        st4_shift,
        st5_stop
    );
    signal rx_state, rx_next_state : state_type;

    signal rx_shift_register : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal rx_shift_register_clear : STD_LOGIC;
    signal rx_shift_register_shift : STD_LOGIC;
    signal rx_shift_register_keep : STD_LOGIC;

    signal rx_clock_counter : unsigned(14 downto 0);
    signal rx_clock_counter_clear : STD_LOGIC;
    signal rx_clock_counter_increment : STD_LOGIC;
    signal rx_clock_counter_keep : STD_LOGIC;

    signal rx_bit_counter : unsigned(3 downto 0);
    signal rx_bit_counter_clear : STD_LOGIC;
    signal rx_bit_counter_increment : STD_LOGIC;
    signal rx_bit_counter_keep : STD_LOGIC;

begin
    rx_shift_register_process : process (
        clk,
        rx_shift_register_clear,
        rx_shift_register_shift,
        rx_shift_register_keep
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' or rx_shift_register_clear = '1' then
                rx_shift_register <= (others => '0');
            elsif rx_shift_register_shift = '1' then
                rx_shift_register <= rx_data & rx_shift_register(7 downto 1);
            elsif rx_shift_register_keep = '1' then
                rx_shift_register <= rx_shift_register;
            end if;
        end if;
    end process rx_shift_register_process;

    rx_clock_counter_process : process (
        clk,
        rx_clock_counter_clear,
        rx_clock_counter_increment
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' or rx_clock_counter_clear = '1' then
                rx_clock_counter <= (others => '0');
            elsif rx_clock_counter_increment = '1' then
                rx_clock_counter <= rx_clock_counter + 1;
            elsif rx_clock_counter_keep = '1' then
                rx_clock_counter <= rx_clock_counter;
            end if;
        end if;
    end process rx_clock_counter_process;

    rx_bit_counter_process : process (
        clk,
        rx_bit_counter_clear,
        rx_bit_counter_increment,
        rx_bit_counter_keep
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' or rx_bit_counter_clear = '1' then
                rx_bit_counter <= (others => '0');
            elsif rx_bit_counter_increment = '1' then
                rx_bit_counter <= rx_bit_counter + 1;
            elsif rx_bit_counter_keep = '1' then
                rx_bit_counter <= rx_bit_counter;
            end if;
        end if;
    end process rx_bit_counter_process;

    sync_process : process (clk)
    begin
        if (clk'event and clk = '1') then
            if (reset = '0') then
                rx_state <= st1_idle;
            else
                rx_state <= rx_next_state;
            end if;
        end if;
    end process;

    output_decode : process (rx_state)
    begin
        rx_available <= '0';

        rx_shift_register_clear <= '0';
        rx_shift_register_shift <= '0';
        rx_shift_register_keep <= '0';

        rx_clock_counter_clear <= '0';
        rx_clock_counter_increment <= '0';
        rx_clock_counter_keep <= '0';

        rx_bit_counter_clear <= '0';
        rx_bit_counter_increment <= '0';
        rx_bit_counter_keep <= '0';

        case rx_state is
            when st1_idle =>
                rx_shift_register_keep <= '1';
                rx_clock_counter_clear <= '1';
                rx_bit_counter_clear <= '1';
                rx_available <= '1';
            when st2_start =>
                if rx_clock_counter = HALF_BPS_CLOCK_COUNT then
                    rx_clock_counter_clear <= '1';
                    rx_bit_counter_clear <= '1';
                    rx_shift_register_keep <= '1';
                else
                    rx_shift_register_keep <= '1';
                    rx_clock_counter_increment <= '1';
                    rx_bit_counter_keep <= '1';
                end if;
            when st3_count =>
                rx_shift_register_keep <= '1';
                rx_clock_counter_increment <= '1';
                rx_bit_counter_keep <= '1';
            when st4_shift =>
                rx_shift_register_shift <= '1';
                rx_clock_counter_clear <= '1';
                rx_bit_counter_increment <= '1';
            when st5_stop =>
                rx_shift_register_keep <= '1';
                rx_clock_counter_increment <= '1';
                rx_bit_counter_keep <= '1';
        end case;

    end process output_decode;

    next_state_decode : process (
        rx_state,
        rx_data,
        rx_clock_counter,
        rx_bit_counter,
        rx_shift_register
        )
    begin
        rx_next_state <= rx_state;
        case rx_state is
            when st1_idle =>
                if rx_data = '0' then
                    rx_next_state <= st2_start;
                else
                    rx_next_state <= st1_idle;
                end if;
            when st2_start =>
                if rx_clock_counter = HALF_BPS_CLOCK_COUNT then
                    rx_next_state <= st3_count;
                else
                    rx_next_state <= st2_start;
                end if;
            when st3_count =>
                if rx_clock_counter = BPS_CLOCK_COUNT then
                    rx_next_state <= st4_shift;
                else
                    rx_next_state <= st3_count;
                end if;
            when st4_shift =>
                if rx_bit_counter = DATA_BITS then
                    rx_next_state <= st5_stop;
                else
                    rx_next_state <= st3_count;
                end if;
            when st5_stop =>
                if rx_clock_counter = BPS_CLOCK_COUNT then
                    rx_next_state <= st1_idle;
                else
                    rx_next_state <= st5_stop;
                end if;
            when others =>
                rx_next_state <= st1_idle;
        end case;
    end process;

    rx_q <= rx_shift_register;
end Behavioral;