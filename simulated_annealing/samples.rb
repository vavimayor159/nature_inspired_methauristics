require 'first_try'

cooling_schedule = SimulatedAnnealing::GeometricCoolingSchedule.new(cooling_rate: 0.7)
example = SimulatedAnnealing.new(initial_guess: [100, 100],
                                 max_iterations: 100)

result = example.run