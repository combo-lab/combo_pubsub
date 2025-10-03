defmodule Combo.PubSub.Mixfile do
  use Mix.Project

  @version "2.1.3"

  def project do
    [
      app: :combo_pubsub,
      version: @version,
      elixir: "~> 1.18",
      name: "Combo.PubSub",
      description: "Distributed PubSub and Presence platform",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      mod: {Combo.PubSub.Application, []},
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps do
    [
      {:ex_check, ">= 0.0.0", only: [:dev], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Chris McCord", "José Valim", "Alexander Songe", "Gary Rennie"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/combo-lab/combo_pubsub"},
      files: ~w(lib test/shared CHANGELOG.md LICENSE.md mix.exs README.md)
    ]
  end

  defp docs do
    [
      main: "Combo.PubSub",
      source_ref: "v#{@version}",
      source_url: "https://github.com/combo-lab/combo_pubsub",
      before_closing_body_tag: %{
        html: """
        <script defer src="https://cdn.jsdelivr.net/npm/mermaid@11.6.0/dist/mermaid.min.js"></script>
        <script>
          let initialized = false;

          window.addEventListener("exdoc:loaded", () => {
            if (!initialized) {
              mermaid.initialize({
                startOnLoad: false,
                theme: document.body.className.includes("dark") ? "dark" : "default"
              });
              initialized = true;
            }

            let id = 0;
            for (const codeEl of document.querySelectorAll("pre code.mermaid")) {
              const preEl = codeEl.parentElement;
              const graphDefinition = codeEl.textContent;
              const graphEl = document.createElement("div");
              const graphId = "mermaid-graph-" + id++;

              mermaid.render(graphId, graphDefinition).then(({svg, bindFunctions}) => {
                graphEl.innerHTML = svg;
                bindFunctions?.(graphEl);
                preEl.insertAdjacentElement("afterend", graphEl);
                preEl.remove();
              });
            }
          });
        </script>
        """,
        epub: ""
      }
    ]
  end
end
