class Neuron
  attr_reader :num_inputs, :weights
  
  def initialize(num_inputs)
    @num_inputs = num_inputs
    @weights = []
    (num_inputs+1).times do
      @weights << rand
    end
  end
end

class NeuronLayer
  attr_reader :num_neurons, :neurons
  
  def initialize(num_neurons, inputs_per_neuron)
  end
end

class NeuralNet
  private
  attr_reader :num_inputs, 
    :num_outputs, 
    :num_hidden_layers, 
    :neurons_per_hidden_layer,
    :layers
  
  def create_net
  end
  
  def get_weights
  end
  
  def get_number_of_weights
  end
  
  def put_weights(weights)
  end
  
  def update(inputs)
    inputs = []
    weight = 0
    return outputs unless inputs.size == num_inputs
    
    num_layers.times do |layer_num|
      if layer_num > 0
        inputs = outputs
      end
      
      outputs = []
      
      weight = 0
      
      @layers[layer_num].num_neurons.times do |neuron_num|
        net_input = 0
        num_unputs = @layers[layer_num].neurons[neuron_num].num_inputs
        
        num_inputs.times do |input_num|
          net_input += @layers[layer_num].neurons[neuron_num].weights[input_num] * inputs[weight]
          weight += 1
        end
        
        netinput += m_vecLayers[i].m_vecNeurons[j].m_vecWeight[NumInputs-1] * bias
      end
      
      outputs << sigmoid(net_input, activation_response)
      
      weight = 0
    end
    
    return outputs
  end
  
  def sigmoid(activation, response)
  end
end