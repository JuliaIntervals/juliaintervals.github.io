using Markdown, JSON, Literate, Documenter
using IntervalArithmetic, IntervalRootFinding, IntervalOptimisation, IntervalConstraintProgramming, TaylorModels

function generate_notebooks()
    nbpath = joinpath("notebooks")
    for (root, _, files) in walkdir("_literate")
        for file in files
            subpath = splitpath(root)[2:end]
            outpath = joinpath(nbpath, subpath...)
            litpath = joinpath(root, file)
            Literate.notebook(litpath, outpath, execute=false, documenter=false)
        end
    end
end

function hfun_index(params)
    section = params[1]
    site = read("structure.json", String)
    site = JSON.parse(site)
    index = "<ol>"
    for sec in site
        if sec["folder"] == section
            for page in sec["pages"]
                filepath = joinpath("/pages", sec["folder"], page["file"])
                nbpath = joinpath("/notebooks", sec["folder"], page["file"])
                nblink = page["notebook"] ? " <a href=\"$(nbpath).ipynb\">[notebook]</a>" : ""
                index *= "<li><p><a href=\"$(filepath)\">$(page["name"])</a>$(nblink)</p></li>"
            end
        end
    end
    index *= "</ol>"
    return index
end

function hfun_doc1(params)
    fname = params[1]
    pname = params[2]

    if startswith(fname, '@') # handle macros
        type = "Macro"
        methodlist = methods(eval(Symbol(fname))).ms
    else
	    methodlist = eval(Meta.parse("methods($pname.$fname, $pname)")).ms
	    type = eval(Meta.parse("Documenter.Utilities.doccat($pname.$fname)"))
	end

    # manual signature needed for functions imported and re-ex ported from other packages
    if length(params) > 2
        sig = "Tuple{$(join(params[3:end], " "))}"
        doc = eval(Meta.parse("Docs.doc($pname.$fname, $sig)"))
    else
        doc = eval(Meta.parse("@doc $pname.$fname"))
    end

    # construct doc
    txt = Markdown.plain(doc)
	body = Franklin.fd2html(txt; internal=true)
    body = replace(body, "<h1"=>s"<h3")
    body = replace(body, "</h1"=>s"</h3")

    # build source code link
    codepath = ""
    if length(methodlist) > 0
        method = methodlist[1]
        prefix = "https://www.github.com/juliaintervals/$(pname).jl/blob/master/"
        filename = string(method.file)
        idx = findfirst("src", filename)
        filename = filename[idx[1]:end]
        filename = replace(filename, "\\" => s"/")
        codepath = prefix*filename*"#L$(method.line)"
        codepath = """<div class="doc-source"><a href="$codepath" target="_blank">source</a></div>"""
    end

    return """
      <div class="docstring">
          <div class="doc-header" id="$fname">
            <a href="#$fname">$fname</a>&nbsp; - $type $codepath</div>
          <div class="doc-content">$body</div>
      </div>
    """
end


function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function create_sidebar(sidebarName="_layout/sidebar.html", siteName="structure.json")
    s = read(siteName, String)
    s = JSON.parse(s)
    open(sidebarName, "w") do f
        write(f, "<h3><label for=\"show-menu\" class=\"show-menu\">Index</label></h3>\n<input type=\"checkbox\" id=\"show-menu\" role=\"button\">\n<div class=\"menu\" id=\"side-menu\">\n")
        for section in s
            write(f, "{{ispage pages/$(section["folder"])/*}}<h2 class=\"sidebar-title\"><a href=\"/pages/$(section["folder"])\" class=\"sidebar-link\">$(section["name"])</a></h2>{{end}}\n")
        end

        write(f, "<ul class=\"menu-list\">\n")
        for section in s
            write(f, "{{ispage pages/$(section["folder"])/*}}\n")
            for page in section["pages"]
                write(f, "<li class=\"menu-list-item {{ispage pages/$(section["folder"])/$(page["file"])/}}active{{end}}\"><a href=\"/pages/$(section["folder"])/$(page["file"])\" class=\"menu-list-link  {{ispage pages/$(section["folder"])/$(page["file"])/}}active{{end}}\">$(page["name"])</a></li>\n")
            end
            write(f, "{{end}}\n")
        end
        write(f, "</ul></div>")
    end
    nothing
end
