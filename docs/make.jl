using Documenter, TestMarkov

makedocs(
    modules = [TestMarkov],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Francesco Alemanno",
    sitename = "TestMarkov.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/francescoalemanno/TestMarkov.jl.git",
    push_preview = true
)
