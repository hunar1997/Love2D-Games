require "NeuronNetwork"

function love.load()
  neuron = create_neuron_network({2,2,1}, {{2}, {3}})

  neuron.weights[1] = {{0.2, 0.5}, {0.3, 0.7}}
  neuron.weights[2] = {{0.1, 0.9}}

  neuron:feed_forward()

end
