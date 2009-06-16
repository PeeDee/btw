Bare Text Wiki (btw)
====================

Camping to implement a wiki over any standard file tree.

Basically I want to store and edit a great deal of unstructured information in as painless and open a way as possible, which means text. And I want links, and code formatting, and very limited styles; so textile is perfect. 90% of the time I am not editing but viewing, and Safari won't display textile for me without something rendering the html for it. If Safari (or Finder's "Quick Look") displayed markdown or textile I wouldn't need to write btw. In-browser editing is painful, so I want to edit outside the browser but have an appropriate edit link embedded in every document and have the browser immediately pick up the edits on a refresh. 

The idea is to browse a directory tree, displaying any documents in formats handled by my browser (eg. pdf, htm, html, jpg, png...), pre-formatting to html any light-weight text markup formats (initially textile; one day markdown, rdoc...). It would be nice to do something pretty with ruby code as well.

I'm using camping, because once you get it running it works pretty well serving dynamic pages from ruby code. On a shared host (Dreamhost) I am only having any luck with .cgi.

I would like to have the app run locally as well as synced to a remote tree and app.

In the spirit of DRY, what btw *will not* do.

* organize hierarchical content - my directory structure does this already
* format anything that the browser already will display, eg. pdf, jpg, html
* edit documents (but it will launch the appropriate editor in the system)
* track & propagate changes to documents (svn and git are already good at this)
* control access (.htaccess online, file permissions locally)
* search (Spotlight locally, Google online)

Release versions

* get shell running on localhost [done]
* establish git repo [done]
* get running on remote host [done]
* render a directory listing of wiki_root [done]

Development path

* browse to underlying directory
* browse to parent (if not root)
* implement separate pub_root from environment
** .htaccess on remote pub_root
** svn syncing local and remote file tree
* render .textile files with redcloth (or SuperRedCloth!!)
* add 'edit me' link
* test opening pdfs, jpgs, gifs, pngs, htm in browser
* migrate legacy content into file tree
* pretty up with css


