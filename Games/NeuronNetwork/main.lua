require "NeuronNetwork"

function love.load()
  neuron = create_neuron_network({2,2,1}, {{2}, {3}})
end
