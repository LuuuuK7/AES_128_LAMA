--	  ________  ________  ________  ___  __    ________  ________  _______           ________  _______   ________           _________  ________     
--	 |\   __  \|\   __  \|\   ____\|\  \|\  \ |\   __  \|\   ____\|\  ___ \         |\   __  \|\  ___ \ |\   ____\         |\___   ___\\   __  \    
--	 \ \  \|\  \ \  \|\  \ \  \___|\ \  \/  /|\ \  \|\  \ \  \___|\ \   __/|        \ \  \|\  \ \   __/|\ \  \___|_        \|___ \  \_\ \  \|\ /_   
--	  \ \   ____\ \   __  \ \  \    \ \   ___  \ \   __  \ \  \  __\ \  \_|/__       \ \   __  \ \  \_|/_\ \_____  \            \ \  \ \ \   __  \  
--	   \ \  \___|\ \  \ \  \ \  \____\ \  \\ \  \ \  \ \  \ \  \|\  \ \  \_|\ \       \ \  \ \  \ \  \_|\ \|____|\  \            \ \  \ \ \  \|\  \ 
--	    \ \__\    \ \__\ \__\ \_______\ \__\\ \__\ \__\ \__\ \_______\ \_______\       \ \__\ \__\ \_______\____\_\  \            \ \__\ \ \_______\
--	     \|__|     \|__|\|__|\|_______|\|__| \|__|\|__|\|__|\|_______|\|_______|        \|__|\|__|\|_______|\_________\            \|__|  \|_______|
--	                                                                                                       \|_________|                             
                                                                                                                                          
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity Package_AES_tb is
end Package_AES_tb;

architecture arch of Package_AES_tb is

    signal a_add, b_add, sum_result : polynom;
    signal a_mult_X, mult_X_result : polynom;
	signal X_mult_X : integer;
    signal a_mult, b_mult, mult_result : polynom;
    signal a, a_inv, inv_ok : polynom;

begin
    process
    begin

        -- 1.1 Fonction add
        a_add <= x"57";
        b_add <= x"83";
		wait for 10ns;
        sum_result <= add(a_add, b_add);
        assert (sum_result = "10011001") report "Erreur: addition 1 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 1.2 Fonction add
        a_add <= "11001100";
        b_add <= "01010101";
		wait for 10ns;
        sum_result <= add(a_add, b_add);
        assert (sum_result = "10011001") report "Erreur: addition 2 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 1.3 Fonction add
        a_add <= "11111111";
        b_add <= "00000000";
		wait for 10ns;
        sum_result <= add(a_add, b_add);
        assert (sum_result = "11111111") report "Erreur: addition 3 incorrecte" severity ERROR;
        wait for 20 ns;

        -- 2.1 Fonction mult_X 
        a_mult_X <= x"57";
		wait for 10ns;
        mult_X_result <= mult_X(a_mult_X);
        assert (mult_X_result = "00110110") report "Erreur: mult_X 1 incorrecte" severity ERROR;
        wait for 10 ns;
		
        -- 2.2 Fonction mult_X 
        a_mult_X <= x"ae";
		wait for 10ns;
        mult_X_result <= mult_X(a_mult_X);
        assert (mult_X_result = "00110110") report "Erreur: mult_X 1 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 2.3 Fonction mult_X 
        a_mult_X <= x"47";
		wait for 10ns;
        mult_X_result <= mult_X(a_mult_X);
        assert (mult_X_result = "00110110") report "Erreur: mult_X 1 incorrecte" severity ERROR;
        wait for 10 ns;
		
        -- 3.1 Fonction mult_2_elem
        b_mult <= x"57";
        a_mult <= x"01";
		wait for 10ns;
        mult_result <= mult_2_elem(a_mult, b_mult);
        assert (mult_result = x"57") report "Erreur: multiplication 1 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 3.2 Fonction mult_2_elem
        b_mult <= x"57";
        a_mult <= x"02";
		wait for 10ns;
        mult_result <= mult_2_elem(a_mult, b_mult);
        assert (mult_result = x"ae") report "Erreur: multiplication 2 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 3.3 Fonction mult_2_elem
        b_mult <= x"57";
        a_mult <= x"04";
		wait for 10ns;
        mult_result <= mult_2_elem(a_mult, b_mult);
        assert (mult_result = x"47") report "Erreur: multiplication 3 incorrecte" severity ERROR;
        wait for 10 ns;
		
		-- 4.1 Fonction inverse
        a <= x"11";
		wait for 10ns;
        a_inv <= invers(a);
		wait for 10ns;
        inv_ok <= mult_2_elem(a, a_inv);
        assert (inv_ok = x"01") report "Inverse 1 incorrecte";
        wait for 10 ns;
		
		-- 4.2 Fonction inverse
        a <= x"22";
		wait for 10ns;
        a_inv <= invers(a);
		wait for 10ns;
        inv_ok <= mult_2_elem(a, a_inv);
        assert (inv_ok = x"01") report "Inverse 1 incorrecte";
        wait for 10 ns;
		
		-- 4.3 Fonction inverse
        a <= x"33";
		wait for 10ns;
        a_inv <= invers(a);
		wait for 10ns;
        inv_ok <= mult_2_elem(a, a_inv);
        assert (inv_ok = x"01") report "Inverse 1 incorrecte";
        wait for 10 ns;
		
-- Fonction inv
        -- a <= x"11";
        -- wait for 10 ns;

        -- a_inv  <= invers(a);
        -- wait for 10 ns;
	-- inv_ok <= mult_2_elem(a_inv, a);
	-- wait for 10 ns;
	-- assert inv_ok/= x"01" report "Inverse correcte" severity NOTE;
	-- assert inv_ok=x"01" report "Inverse incorrecte" severity ERROR;
	-- wait for 10 ns;
       

        -- Arret simulation
        assert false report "Fin de la simulation!" severity NOTE;
        wait;
    end process;

end architecture arch;

