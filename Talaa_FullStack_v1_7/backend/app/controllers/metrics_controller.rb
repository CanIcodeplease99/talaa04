class MetricsController < ApplicationController; def show; render plain: Metrics.export, content_type: 'text/plain; version=0.0.4'; end; end
