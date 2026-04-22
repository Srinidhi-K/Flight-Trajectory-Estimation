function dydt = fcn_systemDynamics(t,  initVals, fp)

xCoordinate = initVals(1);
fp.v_h = initVals(2);
yCoordinate = initVals(3);
fp.v_v = initVals(4);

dydt = zeros(4, 1);   % Initialisation

% x-coordinate calculation
if xCoordinate < fp.max_takeoff_dist && ...
        yCoordinate <= fp.takeoff_height
    acc_h = (fp.Thrust - fp.Drag - fp.RollingResistance) / fp.Mass;      % Acceleration in horizontal direction with rolling resistance
else
    acc_h = (fp.Thrust - fp.Drag) / fp.Mass;                             % Acceleration in horizontal direction without rolling resistance
end

% y-coordinate calculation
if (fp.Lift > fp.Weight || xCoordinate > fp.max_takeoff_dist) && yCoordinate >= 0
    acc_v = (fp.Lift - fp.Weight) / fp.Mass;
else
    acc_v = (fp.Lift - fp.Weight + fp.NormalRxn) / fp.Mass;
end

dydt(1) = fp.v_h;
dydt(2) = acc_h;
dydt(3) = fp.v_v;
dydt(4) = acc_v;
end