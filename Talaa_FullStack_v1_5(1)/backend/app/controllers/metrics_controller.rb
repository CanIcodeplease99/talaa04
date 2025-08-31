class MetricsController < ApplicationController
  def show
    content = Metrics.export
    render plain: content, content_type: 'text/plain; version=0.0.4'
  end
end
