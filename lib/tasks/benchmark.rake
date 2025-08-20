# frozen_string_literal: true

require "action_controller/test_case"
require "benchmark/ips"
require "benchmark/memory"

BM_KWARGS = {
  title: "Lorem ipsum",
  text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
}

require_relative "benchmark/erb_template"
require_relative "benchmark/erubi_template"
require_relative "benchmark/p2_component"
require_relative "benchmark/papercraft_component"
require_relative "benchmark/phlex_component"

module RenderMethods
  def render_view_component_with_template(view_context:)
    ViewComponentWithTemplate.new(**BM_KWARGS).render_in(view_context)
  end

  def render_view_component_with_inline_template(view_context:)
    ViewComponentWithInlineTemplate.new(**BM_KWARGS).render_in(view_context)
  end

  def render_view_component_with_call(view_context:)
    ViewComponentWithCall.new(**BM_KWARGS).render_in(view_context)
  end

  def render_view_component_with_slots(view_context:)
    ViewComponentWithSlots.new.render_in(view_context) do |c|
      c.with_header_content BM_KWARGS.fetch(:title)
      c.with_section_content BM_KWARGS.fetch(:text)
    end
  end

  def render_p2
    P2Component.render(**BM_KWARGS)
  end

  def render_papercraft
    PapercraftComponent.render(**BM_KWARGS)
  end

  def render_phlex
    PhlexComponent.new(**BM_KWARGS).call
  end

  def render_erb
    ErbTemplate.new.render
  end

  def render_erubi
    ErubiTemplate.new.render
  end
end

namespace :benchmark do
  include RenderMethods

  desc "Verify rendering"
  task verify_rendering: :environment do
    view_context = build_test_controller.view_context

    puts "\n---\nERB\n---"
    puts render_erb

    puts "\n---\nErubi\n---"
    puts render_erubi

    puts "\n---\nP2\n---"
    puts render_p2

    puts "\n---\nPapercraft\n---"
    puts render_papercraft

    puts "\n---\nPhlex\n---"
    puts render_phlex

    puts "\n---\nVC (template)\n---"
    puts render_view_component_with_template(view_context:)

    puts "\n---\nVC (inline template)\n---"
    puts render_view_component_with_inline_template(view_context:)

    puts "\n---\nVC (call)\n---"
    puts render_view_component_with_call(view_context:)

    puts "\n---\nVC (slots)\n---"
    puts render_view_component_with_slots(view_context:)
  end

  desc "IPS Benchmark"
  task ips: :environment do
    view_context = build_test_controller.view_context

    Benchmark.ips do |x|
      x.config(time: 5, warmup: 1)

      x.report("ERB") { render_erb }
      x.report("Erubi") { render_erubi }
      x.report("P2") { render_p2 }
      x.report("Papercraft") { render_papercraft }
      x.report("Phlex") { render_phlex }
      x.report("VC (template)") { render_view_component_with_template(view_context:) }
      x.report("VC (inline template)") { render_view_component_with_inline_template(view_context:) }
      x.report("VC (call)") { render_view_component_with_call(view_context:) }
      x.report("VC (slots)") { render_view_component_with_slots(view_context:) }

      x.compare!
    end
  end

  desc "Memory Benchmark"
  task memory: :environment do
    view_context = build_test_controller.view_context

    Benchmark.memory do |x|
      x.report("ERB") { render_erb }
      x.report("Erubi") { render_erubi }
      x.report("P2") { render_p2 }
      x.report("Papercraft") { render_papercraft }
      x.report("Phlex") { render_phlex }
      x.report("VC (template)") { render_view_component_with_template(view_context:) }
      x.report("VC (inline template)") { render_view_component_with_inline_template(view_context:) }
      x.report("VC (call)") { render_view_component_with_call(view_context:) }
      x.report("VC (slots)") { render_view_component_with_slots(view_context:) }

      x.compare!
    end
  end

  def build_test_controller
    ActionController::Base.new
      .tap { |controller|
        ActionDispatch::TestRequest.create
          .tap { |request| request.session = ActionController::TestSession.new }
      }
      .tap { |controller| controller.prepend_view_path "lib/tasks/benchmark/" }
      .extend(Rails.application.routes.url_helpers)
  end
end
