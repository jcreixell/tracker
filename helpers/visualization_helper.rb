module VisualizationHelper

  def encode_chart_data(element, data)
    JSON.dump({
      element: element,
      xkey: 'key',
      ykeys: ['value'],
      labels: ['value'],
      data: data.map{ |element| {key: element.keys.first, value: element.values.first.to_i} }
    })
  end

end
