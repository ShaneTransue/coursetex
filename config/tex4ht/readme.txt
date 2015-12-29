#-------------------------------------------------------------------------------
# Tex4ht Custom Rendering Configuration
#-------------------------------------------------------------------------------
Replace the tex4ht.env configuration file that comes with the installed latex
compiler (ex. MikTex D:\PROGRAMS\MiKTeX\tex4ht\base\win32\tex4ht.env)

The code changed from the original version is included in the:
	tex4ht-snippit.env
file also included within this directory. The purpose of this change is to
improve the image quality of the generated figures and equations for the *.png
images that are generated. The changes specifically modify the command-line
arguments that are provided to dvipng:
	..
	Gdvipng -T tight -x 900 -D 160 -bg Transparent -pp %%2:%%2 %%1 -o %%3
	Gdvipng -T tight -x 900 -D 160 -bg Transparent -gif -pp %%2:%%2 %%1 -o %%3
	..
The resulting changes make the equations appear similar to the result of viewing
a normal equation in a Latex-PDF file at 100%.
