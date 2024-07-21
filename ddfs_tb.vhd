library ieee;
use ieee.std_logic_1164.all;

entity ddfs_tb is
end ddfs_tb;

architecture arch of ddfs_tb is
   constant T      : time    := 10 ns; -- clk period
   signal clk      : std_logic;
   signal reset    : std_logic;
   signal sq_wave, sin_wave : std_logic_vector(15 downto 0);
   signal ramp_wave, tri_wave : std_logic_vector(15 downto 0);
begin
   --*****************************************************************
   -- instantiation
   --*****************************************************************
   -- instantiatie ddfs
   ddfs_unit : entity work.ddfs
      generic map(PW => 30)
      port map(
         clk       => clk,
         reset     => reset,
         fccw      => ("00" & x"010624d"),
         focw      => (others=>'0'),
         pha       => (others=>'0'),
         env       => x"4000",
         pulse_out => open,
         pcm_out   => sin_wave,
         square_out=> sq_wave,
         ramp_out  => ramp_wave,
         triangle_out  => tri_wave
      );
   --*****************************************************************
   -- clock
   --*****************************************************************
   -- 10 ns clock running forever
   process
   begin
      clk <= '0';
      wait for T / 2;
      clk <= '1';
      wait for T / 2;
   end process;
   
   --*****************************************************************
   -- reset
   --*****************************************************************
   -- reset asserted for T/2
   reset <= '1', '0' after T / 2;
   
   --*****************************************************************
   -- run clock
   --*****************************************************************
   process
   begin
      wait for 4 * 1000 * T;                   
      assert false
         report "Simulation Completed"
         severity failure;
   end process;
end arch;
