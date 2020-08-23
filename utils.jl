using IntervalArithmetic, IntervalRootFinding, IntervalOptimisation

using Markdown, Documenter, JSON

function hfun_doc(params)
    fname = params[1]
    # type = length(params) > 1 ? params[2] : Documenter.Utilities.doccat(eval(Meta.parse(fname)))
    doc = eval(Meta.parse("@doc $fname"))
    txt = Markdown.plain(doc)
    # possibly further processing here
    body = Franklin.fd2html(txt, internal=true)
    body = replace(body, "<h1"=>s"<h3")
    body = replace(body, "</h1"=>s"</h3")
    return """
      <div class="docstring">
          <h2 class="doc-header" id="$fname">
            <a href="#$fname">$fname</a></h2>
          <div class="doc-content">$body</div>
      </div>
    """
end

function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
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

function create_sidebar(sidebarName="_layout/sidebar2.html", siteName="structure.json")
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
                write(f, "<li class=\"menu-list-item {{ispage pages/$(section["folder"])/$(page["file"])/}}active{{end}}\"><a href=\"/pages/$(section["folder"])/$(page["file"])/\" class=\"menu-list-link  {{ispage pages/$(section["folder"])/$(page["file"])/}}active{{end}}\">$(page["name"])</a></li>\n")
            end
            write(f, "{{end}}\n")
        end
        write(f, "</ul></div>")
    end
end
