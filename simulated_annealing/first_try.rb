class SimulatedAnnealing
  attr_reader :max_iterations, :current_temperature, :current_iteration, :function_delta, :current_solution,
              :initial_worst_solution_probability, :final_worst_solution_probability, :function_max_change

  def initialize(initial_guess)
    @current_guess = initial_guess
  end

  def run
    while energy_available?
      @current_guess += random_walk

      function_delta = calculate_function_delta

      new_solution = objective_function(@current_guess)

      if solution_improved?(new_solution)
        @current_solution = new_solution
      else
        r = random
        # Accept ifp= exp[°¢f=T]> r
      end

      # Update the bestx* and f*
      @current_iteration += 1
    end
  end

  def objective_function(vector)
    x1 = vector[0]
    x2 = vector[1]

    0.2 + x1**2 + x2**2 - (0.1 * cos(6.0 * Math::PI * x1)) - (0.1 * cos(6.0 * Math::PI * x2))
  end

  def initial_temperature
    @function_max_change / Math.log(@initial_worst_solution_probability)
  end

  def final_temperature
    @function_max_change / Math.log(@final_worst_solution_probability)
  end

  def define_cooling_schedule
    1
  end

  def random_walk
    1
  end

  def calculate_function_delta
    0
  end

  def solution_improved?(new_solution)
    new_solution > @current_solution
  end

  def energy_available?
    current_temperature > final_temperature && current_iteration < max_iterations
  end
end