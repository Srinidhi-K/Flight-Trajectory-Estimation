function xyt = fcn_explicitEuler(flightParams)
fp = flightParams;

xCoordinate = fp.X0(1);
fp.v_h = fp.X0(2);
yCoordinate = fp.X0(3);
fp.v_v = fp.X0(4);
for i = 1:length(fp.TimeArray)-1
    % x-coordinate calculation
    if xCoordinate(i) < fp.max_takeoff_dist && ...
            yCoordinate(i) <= fp.takeoff_height
        acc_h = (fp.Thrust - fp.Drag - fp.RollingResistance) / fp.Mass;      % Acceleration in horizontal direction with rolling resistance
    else
        acc_h = (fp.Thrust - fp.Drag) / fp.Mass;                             % Acceleration in horizontal direction without rolling resistance
    end

    fp.v_h = fp.v_h + acc_h * fp.delta_t;
    xCoordinate(i+1) = xCoordinate(i) + fp.v_h * fp.delta_t;

    % y-coordinate calculation
    if (fp.Lift > fp.Weight || xCoordinate(i) > fp.max_takeoff_dist) && yCoordinate(i) >= 0
        acc_v = (fp.Lift - fp.Weight) / fp.Mass;                        % Acceleration in vertical direction
    else
        acc_v = (fp.Lift - fp.Weight + fp.NormalRxn) / fp.Mass;
    end

    fp.v_v = fp.v_v + acc_v * fp.delta_t;
    yCoordinate(i+1) = yCoordinate(i) + fp.v_v * fp.delta_t;
end

xyt = [xCoordinate',yCoordinate', fp.TimeArray'];

end