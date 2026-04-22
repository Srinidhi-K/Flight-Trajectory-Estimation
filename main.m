%% Estimate 2D trajectory of an RC aircraft during takeoff from an elevated platform
clear fcn_Plot

fp = FlightParams();
tspan = fp.TimeArray';
X0 = fp.X0;

% List of ODE solvers
solvers = {@ode45, @ode23, @ode113, @ode78, @ode89, ...
           @ode15s, @ode23s, @ode23t};
solverNames = {'ode45','ode23','ode113','ode78', ...
               'ode89','ode15s','ode23s','ode23t'};

% Run and plot all ODE solvers
for k = 1:numel(solvers)
    [t, X] = solvers{k}(@(t, X) fcn_systemDynamics(t, X, fp), tspan, X0);
    fcn_Plot([X(:, [1,3]), t], solverNames{k});
end

% Explicit Euler solution
fcn_Plot(fcn_explicitEuler(fp), 'Explicit Euler');

hold off