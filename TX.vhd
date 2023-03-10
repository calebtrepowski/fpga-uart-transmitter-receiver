library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity TX is
    port (
        tx_q : out STD_LOGIC;
        tx_done : out STD_LOGIC;
        tx_start : in STD_LOGIC;
        tx_data : in STD_LOGIC_VECTOR (7 downto 0);
        clk : in STD_LOGIC;
        reset : in STD_LOGIC);
end TX;

architecture Behavioral of TX is

    -- FPGA clock frequency/baud rate frequency
    -- for 9600 bps: 100M/9600
    constant BPS_CLOCK_COUNT : INTEGER := 10416;
    -- for debug purposes
    -- constant BPS_CLOCK_COUNT : INTEGER := 4;

    -- full word to send: 1 start bit ('0') + 8 data bits + 1 stop bit ('1')
    -- assign result - 1
    constant WORD_SENT_BITS : INTEGER := 9;

    type state_type is (
        st1_idle,
        st2_load,
        st3_count,
        st4_shift
    );
    signal tx_state, tx_next_state : state_type;

    signal tx_shift_register : STD_LOGIC_VECTOR(9 downto 0);
    signal tx_shift_register_keep : STD_LOGIC;
    signal tx_shift_register_load : STD_LOGIC;
    signal tx_shift_register_shift : STD_LOGIC;

    signal tx_clock_counter : unsigned(14 downto 0);
    signal tx_clock_counter_clear : STD_LOGIC;
    signal tx_clock_counter_increment : STD_LOGIC;
    signal tx_clock_counter_keep : STD_LOGIC;

    signal tx_bit_counter : unsigned(3 downto 0);
    signal tx_bit_counter_clear : STD_LOGIC;
    signal tx_bit_counter_increment : STD_LOGIC;
    signal tx_bit_counter_keep : STD_LOGIC;
begin

    tx_shift_register_process : process (
        clk,
        tx_shift_register_keep,
        tx_shift_register_load,
        tx_shift_register_shift
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' then
                tx_shift_register <= (others => '0');
            elsif tx_shift_register_load = '1' then
                tx_shift_register <= '1' & tx_data & '0';
            elsif tx_shift_register_shift = '1' then
                tx_shift_register <= '1' & tx_shift_register(9 downto 1);
            elsif tx_shift_register_keep = '1' then
                tx_shift_register <= tx_shift_register;
            end if;
        end if;
    end process tx_shift_register_process;

    tx_clock_counter_process : process (
        clk,
        tx_clock_counter_clear,
        tx_clock_counter_increment
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' or tx_clock_counter_clear = '1' then
                tx_clock_counter <= (others => '0');
            elsif tx_clock_counter_increment = '1' then
                tx_clock_counter <= tx_clock_counter + 1;
            elsif tx_clock_counter_keep = '1' then
                tx_clock_counter <= tx_clock_counter;
            end if;
        end if;
    end process tx_clock_counter_process;

    tx_bit_counter_process : process (
        clk,
        tx_bit_counter_clear,
        tx_bit_counter_increment,
        tx_bit_counter_keep
        )
    begin
        if (clk'event and clk = '1') then
            if reset = '0' or tx_bit_counter_clear = '1' then
                tx_bit_counter <= (others => '0');
            elsif tx_bit_counter_increment = '1' then
                tx_bit_counter <= tx_bit_counter + 1;
            elsif tx_bit_counter_keep = '1' then
                tx_bit_counter <= tx_bit_counter;
            end if;
        end if;
    end process tx_bit_counter_process;

    sync_process : process (clk)
    begin
        if (clk'event and clk = '1') then
            if (reset = '0') then
                tx_state <= st1_idle;
            else
                tx_state <= tx_next_state;
            end if;
        end if;
    end process;

    output_decode : process (tx_state)
    begin
        tx_done <= '0';

        tx_shift_register_keep <= '0';
        tx_shift_register_load <= '0';
        tx_shift_register_shift <= '0';

        tx_clock_counter_clear <= '0';
        tx_clock_counter_increment <= '0';
        tx_clock_counter_keep <= '0';

        tx_bit_counter_clear <= '0';
        tx_bit_counter_increment <= '0';
        tx_bit_counter_keep <= '0';
        case (tx_state) is
            when st1_idle =>
                tx_shift_register_keep <= '1';
                tx_clock_counter_clear <= '1';
                tx_bit_counter_clear <= '1';
                tx_done <= '1';
            when st2_load =>
                tx_shift_register_load <= '1';
                tx_clock_counter_keep <= '1';
                tx_bit_counter_keep <= '1';
            when st3_count =>
                tx_shift_register_keep <= '1';
                tx_clock_counter_increment <= '1';
                tx_bit_counter_keep <= '1';
            when st4_shift =>
                tx_shift_register_shift <= '1';
                tx_clock_counter_clear <= '1';
                tx_bit_counter_increment <= '1';
        end case;
    end process output_decode;

    next_state_decode : process (
        tx_state,
        tx_start,
        tx_data,
        tx_clock_counter,
        tx_bit_counter,
        tx_shift_register
        )
    begin
        tx_next_state <= tx_state;
        case (tx_state) is
            when st1_idle =>
                if tx_start = '0' then
                    tx_next_state <= st2_load;
                else
                    tx_next_state <= st1_idle;
                end if;
            when st2_load =>
                tx_next_state <= st3_count;
            when st3_count =>
                if tx_clock_counter = BPS_CLOCK_COUNT then
                    tx_next_state <= st4_shift;
                else
                    tx_next_state <= st3_count;
                end if;
            when st4_shift =>
                if tx_bit_counter = WORD_SENT_BITS then
                    tx_next_state <= st1_idle;
                else
                    tx_next_state <= st3_count;
                end if;
            when others =>
                tx_next_state <= st1_idle;
        end case;
    end process next_state_decode;

    tx_q <= tx_shift_register(0);

end Behavioral;