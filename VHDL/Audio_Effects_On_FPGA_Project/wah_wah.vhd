-- ================================================================================================
-- Written by Esteban Halliez
-- 
-- This file describes the auto-wah effect, based on an envelop filter. 
-- It applies a variables band-pass filter to the audio signal to perform a "Wah".
-- ================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity auto_wah is
    generic (
        -- Acoustic Parameters
        FC_MIN      : integer := 2500;  -- Low Frequency (Hz approx)
        FC_MAX      : integer := 20000; -- High Frequency (Hz approx)
        
        -- Dynamic Parameters
        ATK_SHIFT   : integer := 1;     -- Opening speed (smaller = faster)
        REL_SHIFT   : integer := 13;    -- Closing speed (higher = slower)
        Q_SHIFT     : integer := 2;     -- Resonance (Quality factor)
        SENSITIVITY : integer := 6      -- Input envelop gain 
    );
    port (
        -- Clocks and Synchronization
        clk_i        : in  std_logic;
        rst_i        : in  std_logic;
        enable_i     : in  std_logic; -- Pulse at 48kHz
        
        -- Audio
        audio_i      : in  std_logic_vector(15 downto 0);
        force_open_i : in  std_logic := '0'; -- '1' to force the filter at its maximum
        audio_o      : out std_logic_vector(15 downto 0)
    );
end entity auto_wah;

architecture rtl of auto_wah is

    -- *** CONSTANTS & CALCULATION SIGNALS ***
    constant INT_BITS : integer := 36; -- Intern Precision (Q19.16)
    
    -- Envelop
    signal env_acc      : unsigned(31 downto 0) := (others => '0');
    signal envelope     : unsigned(15 downto 0) := (others => '0');
    signal freq_cut     : signed(17 downto 0)   := (others => '0');
    
    -- Filter Registers ( LP and BP States)
    signal svf_lp       : signed(INT_BITS-1 downto 0) := (others => '0');
    signal svf_bp       : signed(INT_BITS-1 downto 0) := (others => '0');

    -- Saturation function (Clipping protection)
    function saturate_16(x : signed) return std_logic_vector is
    begin
        if x > 32767 then return x"7FFF";
        elsif x < -32768 then return x"8000";
        else return std_logic_vector(x(15 downto 0));
        end if;
    end function;

begin

    -- Main DSP Process
    process(clk_i)
        -- Variables (Delay like)
        variable abs_v        : unsigned(15 downto 0);
        variable sample_s     : signed(15 downto 0);
        variable env_mapped   : unsigned(15 downto 0);
        variable env_boosted  : unsigned(31 downto 0);
        
        variable mul_fc   : signed(35 downto 0); -- 18x18 bits
        variable hp_v     : signed(INT_BITS-1 downto 0);
        variable bp_v     : signed(INT_BITS-1 downto 0);
        variable lp_v     : signed(INT_BITS-1 downto 0);
        variable mul_q    : signed(INT_BITS-1 downto 0);
        variable mul_f    : signed(INT_BITS+18-1 downto 0); -- 54 bits
        
    begin
        if rising_edge(clk_i) then
            -- System reset
            if rst_i = '1' then
                env_acc  <= (others => '0');
                envelope <= (others => '0');
                svf_lp   <= (others => '0');
                svf_bp   <= (others => '0');
                audio_o  <= (others => '0');
                
            elsif enable_i = '1' then
                -- Input conversion to signed
                sample_s := signed(audio_i);

                --------------------------------------------------------
                -- 1. Envelop Detection (ACCUMULATOR)
                --------------------------------------------------------
                -- Absolute Value
                if sample_s >= 0 then abs_v := unsigned(sample_s);
                else abs_v := unsigned(-sample_s);
                end if;

                -- Setting envelop
                if abs_v > env_acc(31 downto 16) then
                    -- Attack phase (Fast opening)
                    env_acc <= env_acc + resize(abs_v, 32); 
                else
                    -- Release Phase (Slow closing)
                    env_acc <= env_acc - shift_right(env_acc, REL_SHIFT);
                end if;

                envelope <= env_acc(31 downto 16);

                --------------------------------------------------------
                -- 2. Dynamic Mapping (Fc)
                --------------------------------------------------------
                if force_open_i = '1' then
                    env_mapped := (others => '1');
                else
                    -- Sensibility
                    env_boosted := resize(envelope, 32) sll SENSITIVITY;
                    if env_boosted > 65535 then
                        env_mapped := (others => '1');
                    else
                        env_mapped := env_boosted(15 downto 0);
                    end if;
                end if;

                -- Linear Interpolation between FC_MIN and FC_MAX
                mul_fc   := signed("00" & env_mapped) * to_signed(FC_MAX - FC_MIN, 18);
                freq_cut <= mul_fc(33 downto 16) + to_signed(FC_MIN, 18);

                --------------------------------------------------------
                -- 3. SVF Filter Structure (STATE VARIABLE FILTER)
                --------------------------------------------------------
                -- Previous States
                lp_v := svf_lp;
                bp_v := svf_bp;

                -- High-Pass (HP = Input - LP - Q*BP)
                mul_q := shift_right(bp_v, Q_SHIFT); 
                hp_v  := (shift_left(resize(sample_s, INT_BITS), 16)) - lp_v - mul_q;

                -- Band-Pass (BP = F*HP + BP)
                mul_f := freq_cut * hp_v;
                bp_v  := mul_f(INT_BITS+16-1 downto 16) + bp_v;

                -- Low-Pass (LP = F*BP + LP)
                mul_f := freq_cut * bp_v;
                lp_v  := mul_f(INT_BITS+16-1 downto 16) + lp_v;

                -- Setting registers (States)
                svf_lp <= lp_v;
                svf_bp <= bp_v;

                --------------------------------------------------------
                -- 4. Audio Ouput
                --------------------------------------------------------
                -- Output is Band-Pass for Wah effect
                audio_o <= saturate_16(shift_right(bp_v, 16));

            end if;
        end if;
    end process;

end architecture;