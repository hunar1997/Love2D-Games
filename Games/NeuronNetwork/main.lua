require "NeuronNetwork"

function love.load()
  neuron = create_neuron_network({2,2,1})
  neuron:feed_forward({{2}, {3}})
  neuron:get_result()
  neuron:back_propagation({{0.5}})
end
