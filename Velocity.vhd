-- PWM_GEN.VHD (a peripheral module for SCOMP)
-- 2021.03.20
--
-- Generates a square wave with duty cycle dependant on value
-- sent from SCOMP.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY Velocity IS
    PORT(
        RESETN,
        CS         : IN STD_LOGIC;
        CLOCK      : IN STD_LOGIC;
        CLOCK_OUT  : OUT STD_LOGIC
    );
END Velocity;

ARCHITECTURE a OF Velocity IS
    BEGIN


    IO_Handler: PROCESS (RESETN, CS)
    BEGIN
        
        IF (RESETN = '0') THEN
            CLOCK_OUT <= '0';
        ELSIF rising_edge(CS) THEN
            CLOCK_OUT <= '1';
				
        END IF;

    END PROCESS;

    

END a;