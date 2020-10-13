class SimulatedAnnealing
  attr_reader :max_iterations, :current_iteration, :function_delta, :current_solution, :cooling_schedule,
              :temperature_handle

  def initialize(initial_guess:, max_iterations:, function_max_change:, initial_worst_solution_probability:,
                 final_worst_solution_probability:, cooling_schedule:)
    @current_guess = initial_guess
    @max_iterations = max_iterations
    @temperature_handle = TemperatureHandler.new(function_max_change: function_max_change,
                                                 initial_worst_solution_probability: initial_worst_solution_probability,
                                                 final_worst_solution_probability: final_worst_solution_probability,
                                                 cooling_schedule: cooling_schedule)
  end

  def run
    while current_iteration < max_iterations &&
      @current_guess +=

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
      @current_temperature = cooling_schedule.calculate_next_temp(@current_temperature)
    end
  end

  def objective_function(vector)
    x1 = vector[0]
    x2 = vector[1]

    ((1 - x1)**2) + (100 * ((x2 - x1**2)**2))
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

  class AbstractCoolingSchedule
    def calculate_next_temp(iteration)
      raise NotImplementedError
    end
  end

  class LinearCoolingSchedule < AbstractCoolingSchedule
    attr_reader :cooling_rate, :initial_temperature

    def initialize(cooling_rate:, initial_temperature:)
      @cooling_rate = cooling_rate
      @initial_temperature = initial_temperature
    end

    def calculate_next_temp(current_temperature)
      @initial_temperature - (@cooling_rate * iteration_pseudo_time(current_temperature))
    end

    def iteration_pseudo_time(iteration)
      iteration
    end

  end

  class GeometricCoolingSchedule < AbstractCoolingSchedule
    attr_reader :cooling_rate

    def initialize(cooling_rate:)
      raise ArgumentError if cooling_rate.positive? && cooling_rate > 1

      @cooling_rate = cooling_rate
    end

    def calculate_next_temp(current_temperature)
      current_temperature * @cooling_rate
    end
  end

  class TemperatureHandler
    attr_reader :current_temperature, :initial_worst_solution_probability, :final_worst_solution_probability,
                :function_max_change, :cooling_schedule

    def initialize(function_max_change:, initial_worst_solution_probability:, final_worst_solution_probability:,
                   cooling_schedule:)
      @function_max_change = function_max_change
      @initial_worst_solution_probability = initial_worst_solution_probability
      @final_worst_solution_probability = final_worst_solution_probability
      @cooling_schedule = cooling_schedule
      @current_temperature = initial_temperature
    end

    def initial_temperature
      - (@function_max_change / Math.ln(@initial_worst_solution_probability))
    end

    def final_temperature
      - (@function_max_change / Math.ln(@final_worst_solution_probability))
    end

    def next_temperature
      @cooling_schedule.calculate_next_temp(@current_temperature)
    end

    def energy_available?
      current_temperature > final_temperature
    end
  end
end