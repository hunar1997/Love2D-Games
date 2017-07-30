math.randomseed(7)
require "Matrix"

function activate(n)
  return math.tanh(n)
end

function anti_activate(n)
  return 1-n^2
end

function create_neuron_network(topology_)
  object = {}

  object.topology = topology_
  object.weights = {}
  object.layers = {}
  object.learning_rate = 0.01


  for step=1, #topology_-1 do
    object.weights[step] = create_matrix(topology_[step+1], topology_[step]+1)
  end

  function object:feed_forward(inputs)
    self.layers[1] = inputs
    for step=1, #self.topology-1 do
      input_layer = self.layers[step]
      if input_layer[#input_layer][1]~=1 then input_layer[#input_layer+1] = {1} end
      self.layers[step+1] = multiply_matrix(self.weights[step], input_layer, activate)
      print_matrix(self.layers[step]) -- debug
      print_matrix(self.weights[step]) -- debug
    end
  end

  function object:back_propagation(target_values)
    calculated_values = self.layers[#self.layers]
    mean_error = 0
    for i=1,#target_values do
      delta = target_values[i][1] - calculated_values[i][1]
      mean_error = mean_error + delta^2
    end
    mean_error = mean_error / #target_values
    mean_error = math.sqrt(mean_error)

    print("loss: " .. math.abs(mean_error) )
  end

  function object:get_result()
    print_matrix(self.layers[#self.layers]) -- debug
    return self.layers[#self.layers]
  end

  return object
end
