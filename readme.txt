Latex may require additional packages to complete the build of the website
depending on the requirements of htlatex. See Requirements for the list
of required Windows programs. For a linux build, run

TLDR (Linux):
  (1) Install Dvisvgm (add to path)
  (2) Install any additional required latex packages (tex4ht)
  (3) Replace htlatex env config file with: /config/tex4ht/tex4ht.env (os dependent)
  (4) Run make.sh
  
TLDR (Windows):
  (1) Install Cygwin 
    Add /cygwin/bin/ to path before everything else otherwise linux commands such as find
    will throw invalid errors.
  (2) Install MiKTeX (comes with htlatex)
  (3) Install any additional required latex packages
  (4) Replace htlatex env config file with: /config/tex4ht/tex4ht.env (os dependent)
    For MikTex this file is located at C:\yourpath\MiKTeX\tex4ht\base\win32\text4ht.env
  (5) Install Dvisvgm
  (6) Run make.bat
