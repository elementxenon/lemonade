library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.std_logic_arith.all;
    use IEEE.std_logic_unsigned.all;
    
    entity D_Clock is
        Port ( Clk : in STD_LOGIC;
               Reset : in STD_LOGIC;
               OutputSegment : out STD_LOGIC_VECTOR (6 downto 0);
               OutputLED : out STD_LOGIC;
    
               an0 : out STD_LOGIC;
               an1 : out STD_LOGIC;
               an2 : out STD_LOGIC;
               an3 : out STD_LOGIC);
    end D_Clock;
    
    
    architecture Behavioral of D_Clock is
    
    signal f_cnt_1          : integer range 0 to 1001:=0;
    signal f_cnt_2          : integer range 0 to 1001:=0;
    signal f_cnt_100        : integer range 0 to 101:=0;
    signal f_cnt_9          : integer range 0 to 10:=0;
    signal f_cnt_5          : integer range 0 to 10:=0;
    signal f_cnt_9_min      : integer range 0 to 10:=0;
    signal f_cnt_5_min      : integer range 0 to 2:=0;
    signal f_segment0       : std_logic_vector(6 downto 0):= "1111111";
    signal f_segment1       : std_logic_vector(6 downto 0):= "1111111";
    signal f_segment2       : std_logic_vector(6 downto 0):= "1111111";
    signal f_segment3       : std_logic_vector(6 downto 0):= "1111111";
    signal Q                : std_logic :='0';
    
    
    begin
     
     OutputLED  <= '1';
     ---------------------------------------------
         Sev_seg :process(Clk)
                 begin
                 if(Clk'event and Clk='1') then
                 
                case f_cnt_2  is 
                when 0 to 249 =>
                   OutputSegment <= f_segment0;
     
                     an0        <='0';
                     an1        <='1';
                     an2        <='1';
                     an3        <='1';
               
                
                when 250 to 499 =>
                   OutputSegment <= f_segment1;
     
                     an0        <='1';
                     an1        <='0';
                     an2        <='1';
                     an3        <='1';
                     
               
                when 500 to 749 =>
                   OutputSegment <= f_segment2;
     
                     an0        <='1';
                     an1        <='1';
                     an2        <='0';
                     an3        <='1';
                     
               when others => 
                     OutputSegment <= f_segment3;
                      an0        <='1';
                      an1        <='1';
                      an2        <='1';
                      an3        <='0';
               end case;
                end if;
             end process;
    ---------------------------------------------
     counter1:process(Reset, Clk)
     begin
        if(Reset = '1') then
            f_cnt_1 <=0;
        elsif(Clk'event and Clk='1') then
            f_cnt_1 <= f_cnt_1 + 1;
            if(f_cnt_1 = 1000) then
                f_cnt_1 <= 0;
            end if;
        end if;
        end process;
     ---------------------------------------- 
      counter2:process(Reset, Clk)
        begin
           if(Reset = '1') then
               f_cnt_2 <=0;
           elsif(Clk'event and Clk='1') then
             if (f_cnt_1 = 1000) then
               f_cnt_2 <= f_cnt_2 + 1;
               if(f_cnt_2 = 1000) then 
                   f_cnt_2 <= 0;
               end if; 
           end if;  
           end if;
        end process;
    -----------------------------
     counter100:process(Reset, Clk)
          begin
             if(Reset = '1') then
                 f_cnt_100 <=0;
             elsif(Clk'event and Clk='1') then
               if (f_cnt_1 = 1000 and f_cnt_2 = 1000) then --and f_cnt_2 = 1000
                 f_cnt_100 <= f_cnt_100 + 1;
                 if(f_cnt_100 = 100) then
                     f_cnt_100 <= 99;
                 end if;
               end if;  
             end if;
          end process;
          
     counter9:process(Reset, Clk)
        begin
                  if(Reset = '1') then
                      f_cnt_9 <=0;
                  elsif(Clk'event and Clk='1') then
                    if (f_cnt_1 = 1000 and f_cnt_2 = 1000) then
                    if (f_cnt_100 = 100) then
                      f_cnt_9 <= f_cnt_9 + 1;
                      if(f_cnt_9 = 9) then
                          f_cnt_9 <= 0;
                      end if;
                    end if;
                  end if;
                end if;  
     end process;
    ------------------------------------------    
      counter5:process(Reset, Clk)
               begin
              if (f_cnt_9 = 9) then
                      if(Reset = '1') then
                          f_cnt_5 <=0;
                      elsif (f_cnt_9 = 9) then
                      if(Clk'event and Clk='1') then
                        if (f_cnt_1 = 1000 and f_cnt_2 = 1000) then
                        if (f_cnt_100 = 100) then
                        if (f_cnt_9 = 9) then
                            f_cnt_5 <= f_cnt_5 + 1;
                          if(f_cnt_5 = 5) then
                              f_cnt_5 <= 0;
                          end if;
                        end if;
                      end if;
                    end if; 
                  end if;
               end if;
               end if;  
            end process;
     ------------------------------------
--          counter92:process(Reset, Clk)
--        begin
--                  if(Reset = '1') then
--                      f_cnt_9_min <=0;
--                  elsif(Clk'event and Clk='1') then
--                    if (f_cnt_1 = 1000 and f_cnt_2 = 1000) then
--                    if (f_cnt_100 = 100) then
--                    if (f_cnt_9 = 9) and (f_cnt_5 = 5) then
--                      f_cnt_9_min <= f_cnt_9_min + 1;
--                     if(f_cnt_9_min = 9 and (Q = '0' and f_cnt_5_min = 0)) then
--                          f_cnt_9_min <= 0;
--                          f_cnt_5_min <= 1;
--                          Q <= not Q;
--                     else if(f_cnt_9_min = 9 and (Q = '1' and f_cnt_5_min = 1)) then
--                            f_cnt_9_min <= 0;
--                            f_cnt_5_min <=2;
--                            Q <= not Q;
--                      else if(f_cnt_9_min = 4 and (Q = '0' and f_cnt_5_min = 2)) then
--                            f_cnt_9_min <=1;
--                            f_cnt_5_min <=0;
--                            Q <= Q;
--                      end if;
--                      end if;
--                    end if;
--                  end if;
--                end if;  
--                end if;
--                end if;
--            end process;
--     -----------------------------------
       

     segment0: process (Reset, Clk)
     begin
         if(Reset = '1') then
             f_segment0 <= "1111111";
         elsif (Clk'event and Clk='1') then
         
        
             case f_cnt_9 is
                 when 0 =>
                 f_segment0 <= "1000000";
                 when 1 =>
                 f_segment0 <= "1111001";
                 when 2 =>
                 f_segment0 <= "0100100";
                 when 3 =>
                 f_segment0 <= "0110000";
                 when 4 =>
                 f_segment0 <= "0011001";
                 when 5 =>
                 f_segment0 <= "0010010";
                 when 6 =>
                 f_segment0 <= "0000010";
                 when 7 =>
                 f_segment0 <= "1111000";
                 when 8 =>
                 f_segment0 <= "0000000";
                 when 9 =>
                 f_segment0 <= "0010000";
                 when others=>
                 f_segment0 <= "1111111";
              end case;
          end if;
     end process;  
    -------------------------------------------
     segment1: process (Reset, Clk)
        begin
            if(Reset = '1') then
                f_segment1 <= "1000000";
                
            elsif (Clk'event and Clk='1') then
                case f_cnt_5 is
                    when 0 =>
                    f_segment1 <= "1000000";
                    when 1 =>
                    f_segment1 <= "1111001";
                    when 2 =>
                    f_segment1 <= "0100100";
                    when 3 =>
                    f_segment1 <= "0110000";
                    when 4 =>
                    f_segment1 <= "0011001";
                    when 5 =>
                    f_segment1 <= "0010010";
                    when 6 =>
                    f_segment1 <= "0000010";
                    when 7 =>
                    f_segment1 <= "1111000";
                    when 8 =>
                    f_segment1 <= "0000000";
                    when 9 =>
                    f_segment1 <= "0010000";
                    when others=>
                    f_segment1 <= "1111111";
                 end case;
             end if;
       end process;  
       ----------------------------------------------------
       segment2: process (Reset, Clk)
        begin
            if(Reset = '1') then
                f_segment2 <= "1000000";
                
            elsif (Clk'event and Clk='1') then
                case f_cnt_9_min is
                    when 0 =>
                    f_segment2 <= "1000000";
                    when 1 =>
                    f_segment2 <= "1111001";
                    when 2 =>
                    f_segment2 <= "0100100";
                    when 3 =>
                    f_segment2 <= "0110000";
                    when 4 =>
                    f_segment2 <= "0011001";
                    when 5 =>
                    f_segment2 <= "0010010";
                    when 6 =>
                    f_segment2 <= "0000010";
                    when 7 =>
                    f_segment2 <= "1111000";
                    when 8 =>
                    f_segment2 <= "0000000";
                    when 9 =>
                    f_segment2 <= "0010000";
                    when others=>
                    f_segment2 <= "1111111";
                 end case;
             end if;
       end process;  
       -----------------------------------------------------------
       segment3: process (Reset, Clk)
        begin
            if(Reset = '1') then
                f_segment3 <= "1000000";
                
            elsif (Clk'event and Clk='1') then
                case f_cnt_5_min is
                    when 0 =>
                    f_segment3 <= "1000000";
                    when 1 =>
                    f_segment3 <= "1111001";
                    when 2 =>
                    f_segment3 <= "0100100";
                    when 3 =>
                    f_segment3 <= "0110000";
                    when 4 =>
                    f_segment3 <= "0011001";
                    when 5 =>
                    f_segment3 <= "0010010";
                    when 6 =>
                    f_segment3 <= "0000010";
                    when 7 =>
                    f_segment3 <= "1111000";
                    when 8 =>
                    f_segment3 <= "0000000";
                    when 9 =>
                    f_segment3 <= "0010000";
                    when others=>
                    f_segment3 <= "1111111";
                 end case;
             end if;
       end process;  
       ---------------------------------------------------------
       end Behavioral;