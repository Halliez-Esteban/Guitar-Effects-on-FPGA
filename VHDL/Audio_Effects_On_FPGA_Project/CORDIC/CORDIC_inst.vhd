	component CORDIC is
		port (
			a      : in  std_logic_vector(17 downto 0) := (others => 'X'); -- a
			areset : in  std_logic                     := 'X';             -- reset
			clk    : in  std_logic                     := 'X';             -- clk
			x      : in  std_logic_vector(16 downto 0) := (others => 'X'); -- x
			y      : in  std_logic_vector(16 downto 0) := (others => 'X'); -- y
			xo     : out std_logic_vector(17 downto 0);                    -- xo
			yo     : out std_logic_vector(17 downto 0)                     -- yo
		);
	end component CORDIC;

	u0 : component CORDIC
		port map (
			a      => CONNECTED_TO_a,      --      a.a
			areset => CONNECTED_TO_areset, -- areset.reset
			clk    => CONNECTED_TO_clk,    --    clk.clk
			x      => CONNECTED_TO_x,      --      x.x
			y      => CONNECTED_TO_y,      --      y.y
			xo     => CONNECTED_TO_xo,     --     xo.xo
			yo     => CONNECTED_TO_yo      --     yo.yo
		);

