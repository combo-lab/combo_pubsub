%{
  configs: [
    %{
      name: "default",
      checks: %{
        disabled: [
          {Credo.Check.Refactor.Nesting, []},
          {Credo.Check.Design.TagTODO, []}
        ]
      }
    }
  ]
}
