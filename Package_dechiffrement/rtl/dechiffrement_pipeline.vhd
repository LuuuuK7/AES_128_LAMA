--	  ________  ________  ________  ___  __    ________  ________  _______           ________  _______   ________      
--	 |\   __  \|\   __  \|\   ____\|\  \|\  \ |\   __  \|\   ____\|\  ___ \         |\   __  \|\  ___ \ |\   ____\     
--	 \ \  \|\  \ \  \|\  \ \  \___|\ \  \/  /|\ \  \|\  \ \  \___|\ \   __/|        \ \  \|\  \ \   __/|\ \  \___|_    
--	  \ \   ____\ \   __  \ \  \    \ \   ___  \ \   __  \ \  \  __\ \  \_|/__       \ \   __  \ \  \_|/_\ \_____  \   
--	   \ \  \___|\ \  \ \  \ \  \____\ \  \\ \  \ \  \ \  \ \  \|\  \ \  \_|\ \       \ \  \ \  \ \  \_|\ \|____|\  \  
--	    \ \__\    \ \__\ \__\ \_______\ \__\\ \__\ \__\ \__\ \_______\ \_______\       \ \__\ \__\ \_______\____\_\  \ 
--	     \|__|     \|__|\|__|\|_______|\|__| \|__|\|__|\|__|\|_______|\|_______|        \|__|\|__|\|_______|\_________\
--	                                                                                                      \|_________|                                                                                                     \|_________|                             
                                                                                                                                          
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;
use work.package_dechiffrement.all;

entity dechiffrement_pipeline is 
	
	generic (
		constant Nbit : positive :=128
	);
	
	port(
	
		resetn  : in std_logic;
		clk		: in std_logic;
		state   : in std_logic_vector (Nbit-1 downto 0);
		flag    : in std_logic;
		key 	: in std_logic_vector ((Nbit-1)*11 downto 0);
		out_data: out std_logic_vector (Nbit-1 downto 0)
	);
	

end entity;

architecture arch of dechiffrement_pipeline is

	type regkey is array (0 to 10) of std_logic_vector (Nbit-1 downto 0);
	
	signal reg_key : regKey;
	constant zero_state : std_logic_vector(Nbit-1 downto 0) :=(others =>'0');
	signal reg_state : std_logic_vector(Nbit-1 downto 0);

	signal data_out : std_logic_vector((16*Nbit)-1 downto 0);	
	signal addr    :std_logic_vector((16*Nbit)-1 downto 0);
	signal en 	:std_logic;

											 
									  
	
	begin
	
	process (clk, resetn, flag) is 
	
	--DÃ©claration de variable
	variable end_xor, vector_state_i, vector_state_end, rom_data_out_i,rom_data_out_end : vector_state;
	variable array_state_i, end_round,array_state_end : array_state;
	variable u,v: integer;
	
	begin
		if resetn = '0' then 
			reg_state <= zero_state;
			out_data <= zero_state;
			en <= '0';
			for i in 10 downto 0 loop
				reg_key(i) <= zero_state;
			end loop;
		elsif rising_edge(clk) then
			
			-- Memorisation
			reg_state <= state;
			

			
			
			for round in 10 downto 0 loop
				reg_key(round) <= key((Nbit*(round+1)) downto Nbit*round);
						
			-- Round 10 (initial)
				if round = 10 then
					if flag = '1' then
						end_xor := addRoundKey(reg_state,reg_key(round));
					else 
						end_xor := addRoundKey(reg_state,zero_state);
						
					end if;
					vector_state_i := end_xor;
				
				
			-- Round 9 au  1 (intermediaire)
			
				elsif round< 10 and round > 0 then
					
					array_state_i := create_array_state(vector_state_i);
					
					--invShiftRow
					vector_state_i:=invShiftRow(array_state_i);
					
					
			
					--Fonctionn invSubByte
					en <= '1';
					addr <= vector_state_i;
					rom_data_out_i := data_out;
					 en <= '0';
			
					--Fonction addRoundKey
					if flag='1' then 
						vector_state_i := addRoundKey(rom_data_out_i,reg_key(round));
					else 
						vector_state_i := addRoundKey(rom_data_out_i,(others=>'0'));
					end if;
					--Fonction invMixColumns
					array_state_i  := create_array_state(vector_state_i);
					array_state_i  := invMixColumns(array_state_i);
					vector_state_i := create_vector_state(array_state_i);
				
				else 
				
				-- Dernier round
					end_round := create_array_state(vector_state_i);
					
					--Fonctionn invShiftRow
					vector_state_end:=invShiftRow(end_round);
					
					--Fonctionn invSubByte
					en <= '1';
					addr <= vector_state_end;
					rom_data_out_end := data_out;
					en <= '0';
					
					--Fonction addRoundKey
					if flag='1' then
						out_data <= addRoundKey(rom_data_out_end,reg_key(round));
					else 
						out_data <= addRoundKey(rom_data_out_end,(others=>'0'));
					
					end if;
					
					
				
				end if;
				
			
			end loop;	
			
		end if;
		
	
	end process;
	
	
	invsbox: for i in 15 downto 0 generate
	rom_inSbox: entity work.rom_invsbox 
					port map(
						
						clk => clk,
						addr =>addr(8*(i+1)-1 downto 8*i),
						en  => en,
						data_out => data_out(8*(i+1)-1 downto 8*i)
						);
	end generate;
						
						
	
	


end architecture;
