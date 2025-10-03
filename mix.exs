defmodule Combo.PubSub.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @description "Distributed Pub/Sub system and presence tracking system."
  @source_url "https://github.com/combo-lab/combo_pubsub"
  @changelog_url "https://github.com/combo-lab/combo_pubsub/blob/v#{@version}/CHANGELOG.md"

  def project do
    [
      app: :combo_pubsub,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      description: @description,
      source_url: @source_url,
      homepage_url: @source_url,
      docs: docs(),
      package: package(),
      aliases: aliases()
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
      licenses: ["MIT"],
      links: %{
        Source: @source_url,
        Changelog: @changelog_url
      },
      files: ~w(lib mix.exs README.md CHANGELOG.md LICENSE)
    ]
  end

  defp aliases do
    [
      publish: ["hex.publish", "tag"],
      tag: &tag_release/1
    ]
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as v#{@version}")
    System.cmd("git", ["tag", "v#{@version}"])
    System.cmd("git", ["push", "--tags"])
  end

  defp docs do
    [
      extras: ["README.md", "CHANGELOG.md", "LICENSE"],
      source_url: @source_url,
      source_ref: "v#{@version}",
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
