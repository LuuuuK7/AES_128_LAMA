library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity dechiffrement is
  generic (
    Nbit : positive := 128; )
  port (
    State       : in  std_logic_vector(Nbit-1    downto 0);
    Sc10       : in  std_logic_vector(NBit-1    downto 0);  
    Sc9       : in  std_logic_vector(NBit-1    downto 0);  
    Sc8       : in  std_logic_vector(NBit-1    downto 0);  
    Sc7       : in  std_logic_vector(NBit-1    downto 0);  
    Sc6       : in  std_logic_vector(NBit-1    downto 0);  
    Sc5       : in  std_logic_vector(NBit-1    downto 0);  
    Sc4       : in  std_logic_vector(NBit-1    downto 0);  
    Sc3       : in  std_logic_vector(NBit-1    downto 0);  
    Sc2       : in  std_logic_vector(NBit-1    downto 0);  
    Sc1       : in  std_logic_vector(NBit-1    downto 0);  
  );
end entity;

