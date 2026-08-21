LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity chorus is
    port (
        clock_50    : in std_logic;
        clock_48kHz : in std_logic; 
        audio_in    : in std_logic_vector(15 downto 0);
        audio_out   : out std_logic_vector(15 downto 0);
		  chorus_rate : in integer range 0 to 400
    );
end chorus;

architecture chorus_circuit of chorus is

    --Sinus LUT used for amplitude 
    component SinusLUT
        Port (
            clk      : in  std_logic;
            address  : in  std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(6 downto 0)
        );
    end component;

	--RAM
    component RAM_chorus
        PORT (
            clock     : IN STD_LOGIC := '1';
            data      : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            rdaddress : IN STD_LOGIC_VECTOR (12 DOWNTO 0);
            wraddress : IN STD_LOGIC_VECTOR (12 DOWNTO 0);
            wren      : IN STD_LOGIC := '0';
            q         : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    end component;

	 --RAM
    signal clock_48kHz_sample : std_logic_vector(1 downto 0);
    signal ram_output : std_logic_vector(15 downto 0);
    signal ram_read_adr, ram_write_adr : std_logic_vector(12 downto 0);
    signal ram_data : std_logic_vector(15 downto 0);
    signal ram_write_en : std_logic;

	 --Read/Write RAM
    signal counter_write : integer range 0 to 8000 := 1000;
    signal counter_read1, counter_read2, counter_read3 : integer range 0 to 8000 := 0; 
    signal delayed_sample1_s, delayed_sample2_s, delayed_sample3_s : signed(15 downto 0) := (others => '0'); 
    
	 --Calculation
    signal dry_signal : signed(15 downto 0);
    signal mixed_signal : signed(16 downto 0); 
    signal read_state : integer range 0 to 5 := 0;

    -- LFO Signals
    signal lfo_counter : unsigned(19 downto 0) := (others => '0');
    signal phase_acc   : unsigned(7 downto 0) := (others => '0'); -- Adresse de base LUT
    signal sine_out    : std_logic_vector(6 downto 0);            -- Sortie brute LUT
    signal lfo_offset1, lfo_offset2, lfo_offset3 : integer := 0;

begin

	 -- Hardware written Sinus in LUTs
    SINE_INST : SinusLUT port map (
        clk      => clock_50,
        address  => std_logic_vector(phase_acc),
        data_out => sine_out
    );

	 -- RAM Instance to store datas to be added into output calculation
    RAM_INST : RAM_chorus PORT MAP (
        clock => clock_50, data => ram_data, q => ram_output,
        rdaddress => ram_read_adr, wraddress => ram_write_adr, wren => ram_write_en
    );

    process(clock_50)
    begin
        if rising_edge(clock_50) then
            clock_48kHz_sample <= clock_48kHz_sample(0) & clock_48kHz;

				-- Reading in RAM at 48Khz clock falling edge
            if (clock_48kHz_sample = "01") then
                --Write Counter logic 
                if(counter_write >= 7999) then counter_write <= 0;
                else counter_write <= counter_write + 1;
                end if;

                -- Chorus Rate
                if lfo_counter >= chorus_rate then 
                    lfo_counter <= (others => '0');
                    phase_acc <= phase_acc + 1; 
                else
                    lfo_counter <= lfo_counter + 1;
                end if;

                -- Offset Calculation (Depth)
                lfo_offset1 <= to_integer(unsigned(sine_out)) * 4;
                
					 -- At the next rising edge, we will read 3 previous input signals stored in RAM to add them to the incoming input signal
                counter_read1 <= (counter_write + 8000 - 600 - lfo_offset1) mod 8000;
                counter_read2 <= (counter_write + 8000 - 1000 - (lfo_offset1/2)) mod 8000;
                counter_read3 <= (counter_write + 8000 - 1400 - (lfo_offset1/4)) mod 8000;
					 --RAM ready to be read
                read_state <= 1;
            end if;

            -- Reading in RAM for three previous samples
            case read_state is
                when 1 => ram_read_adr <= std_logic_vector(to_unsigned(counter_read1, 13)); read_state <= 2;
                when 2 => delayed_sample1_s <= signed(ram_output);--Voice 1
                          ram_read_adr <= std_logic_vector(to_unsigned(counter_read2, 13)); read_state <= 3;
                when 3 => delayed_sample2_s <= signed(ram_output);--Voice 2
                          ram_read_adr <= std_logic_vector(to_unsigned(counter_read3, 13)); read_state <= 4;
                when 4 => delayed_sample3_s <= signed(ram_output); read_state <= 0;--Voice 3
                when others => null;
            end case;
				--Setting the RAM pointer back to writing adress for the next input signal incoming
            ram_write_adr <= std_logic_vector(to_unsigned(counter_write, 13));
        end if;
    end process;

    -- Writing in RAM at 48Khz clock rising edge
    process(clock_50) begin
        if rising_edge(clock_50) then
            if(clock_48kHz_sample = "10") then
					 --Writing the current audio input sample in RAM for following outputs
                ram_data <= audio_in; ram_write_en <= '1';
            else ram_write_en <= '0'; end if;
        end if;
    end process;

    -- Mixing signals 50% Dry + 25% per voice
    dry_signal <= signed(audio_in);
    mixed_signal <= resize(shift_right(dry_signal, 1), 17) + 
                    resize(shift_right(delayed_sample1_s, 2), 17) + 
                    resize(shift_right(delayed_sample2_s, 2), 17) + 
                    resize(shift_right(delayed_sample3_s, 2), 17);

    -- Anti-Overflow Logic
    process(clock_50) begin
        if rising_edge(clock_50) then
            if mixed_signal > 32767 then audio_out <= std_logic_vector(to_signed(32767, 16));
            elsif mixed_signal < -32768 then audio_out <= std_logic_vector(to_signed(-32768, 16));
            else audio_out <= std_logic_vector(mixed_signal(15 downto 0)); end if;
        end if;
    end process;

end chorus_circuit;