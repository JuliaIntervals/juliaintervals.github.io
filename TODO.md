# TODO LIST

## API DOCS

At the moment the apidocs are generated using `hfun_doc`. This somehow works but requires some polishing, particularly
 - Add style to documentation, currently it's pretty ugly
 - Figure out how to get link to source code like Documenter does
 - Check how it behaves if the function has several methods and each method has its own docstring a

Possible alternatives are

1. Generate the documentation of methods with documenter and the link APIDOCS sends to documenter page (similar to sciml.ai)
    - PROS: easy to do
    - CONS: maybe not optimal if the documentation page looks different from the original webpage. Also how to get back to homepge.

2. Generate the documentation with documenter. Extract somehow the content part from html page and insert it into original webpage

## Tutorials

At the moment the tutorials are generated using Literate+Franklin. This works nicely, but has some limitations if e.g. we want to display the code as repl. 

1. Check weave as alternative to literate.

2. Atm each tutorial has a link to the notebook (if I remembered to add it :D), add link to open notebook in binder

3. Can we make the webpage interactive, i.e. allow running julia code on the webpage? Thebelab allows to do this with python at least. Does it work for julia? Can we use Pluto for this?

## AESTHETIC FIXES

- Homepage:
    1. Improve reactiveness: when reducing the window size, the buttons on the masthead get hidden behind the hamburger button. This is nice, however the current settings hide the buttons too early, maybe reduce the `max-width` somewhere in the css
    3. remove the grey bar on the homepage and put the logo in the middle on white background (change logo font from white to black logically)?
    4. change figures to svg
    5. Fix logo (fix font, thicker black line)

- Sidebar
    1. move sidebar a little higher
    2. modify sidebar so that when a page is active it also displays the page content as child menu
    3. I am not sure whether the INDEX button hiding the sidebar on small screens is optimal
 