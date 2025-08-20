# frozen_string_literal: true

require "action_controller/test_case"
require "benchmark/ips"
require "benchmark/memory"
require "cgi"

require_relative "benchmark/erb_app"
require_relative "benchmark/erubi_app"
require_relative "benchmark/p2_app"
require_relative "benchmark/papercraft_app"
require_relative "benchmark/phlex_app"
require_relative "benchmark/view_component_app/view_component_app"

namespace :benchmark do
  desc "IPS Benchmark"
  task ips: :environment do
    title = text = "Lorem ipsum"
    view_context = build_test_controller.view_context

    Benchmark.ips do |x|
      x.config(time: 5, warmup: 2)

      x.report("ViewComponent") do
        ViewComponentApp.new do |c|
          c.with_header_content(title)
          c.with_stage_content(text)
        end.render_in(view_context)
      end

      x.report("P2") do
        P2App.render(title:, text:)
      end

      x.report("Papercraft") do
        PapercraftApp.render(title:, text:)
      end

      x.report("Phlex") do
        PhlexApp.new(title:, text:).call
      end

      x.report("ERB") do
        ErbApp.new.render
      end

      x.report("Erubi") do
        ErubiApp.new.render
      end

      x.compare!
    end
  end

  desc "Memory Benchmark"
  task memory: :environment do
    view_context = build_test_controller.view_context
    title = "Lorem Ipsum"
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

    Benchmark.memory do |x|
      x.report("ViewComponent") do
        ViewComponentApp.new do |c|
          c.with_header_content(title)
          c.with_stage_content(text)
        end.render_in(view_context)
      end

      x.report("P2") do
        P2App.render(title:, text:)
      end

      x.report("Papercraft") do
        PapercraftApp.render(title:, text:)
      end

      x.report("Phlex") do
        PhlexApp.new(title:, text:).call
      end

      x.report("ERB") do
        ErbApp.new.render
      end

      x.report("Erubi") do
        ErubiApp.new.render
      end

      x.compare!
    end
  end

  def build_test_controller
    ActionController::Base.new
      .tap { |controller|
        ActionDispatch::TestRequest.create
          .tap { |request| request.session = ActionController::TestSession.new }
      }
      .extend(Rails.application.routes.url_helpers)
  end
end
