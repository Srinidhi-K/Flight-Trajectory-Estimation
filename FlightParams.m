classdef FlightParams
    properties
        takeoff_height = 0.5;      % take-off height above the ground in m
        a = 77.8;                  % First Coefficient in the Thrust Equation
        b = 5.4;                   % Second Coefficient in the Thrust Equation
        Cl = 0.85;                 % Lift Coefficient
        Cd = 0.2;                  % Drag Coefficient
        Span = 1;                  % wing span in m
        Chord = 0.16;              % Chord of the wing
        Mass = 1.3;                % mass of the plane in kg
        max_takeoff_dist = 2.4;    % maximum take-off distance in m
        coeff_friction = 0.04;     % coefficient of rolling friction
        v_wind = 0;                % Positive if head wind and negative if tail wind
        delta_t = 0.01;            % time step taken for each loop
        t_start = 0;               % Start time
        t_end = 12;                % End time
        yCoorInit = 0.5;           % Initial y-coordinate
    end

    properties(Hidden)
        density = 1.225;           % Density of Air in kg/m^3
        xCoorInit = 0;             % Initial x-coordinate
        v_hInit = 0;               % Initial horizontal velocity
        v_vInit = 0;               % Initial vertical velocity
        v_h = 0;
        v_v = 0;
    end

    properties(Dependent)
        S                          % Wing Planform Area in m^2
        Weight                     % total weight of the plane in N
        X0                         % Initial Conditions
        TimeArray                  % Generate time array
        Drag;
        Lift;
        Thrust;
        RollingResistance
        NormalRxn   
    end

    methods
        function val = get.S(this)
            val = this.Span * this.Chord;
        end

        function val = get.Weight(this)
            val = this.Mass * 9.81;
        end

        function val = get.X0(this)
            val = [this.xCoorInit; this.v_hInit; this.yCoorInit; this.v_vInit];
        end

        function val = get.TimeArray(this)
            val = this.t_start : this.delta_t : this.t_end;
        end

        function val = get.Drag(this)
            val =  0.5 * this.density * this.Cd * this.S * (this.v_h - this.v_wind)^2;
        end

        function val = get.Lift(this)
            val =  0.5 * this.density * this.Cl * this.S * (this.v_h - this.v_wind)^2;
        end

        function val = get.Thrust(this)
            val = this.a - this.b * this.v_h;                                   % Thrust as a function of velocity
        end

        function val = get.RollingResistance(this)
            val = this.NormalRxn * this.coeff_friction;  % total rolling resistance in N
        end

        function val = get.NormalRxn(this)
            val = this.Weight - this.Lift;
        end
    end
end