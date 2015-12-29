#-------------------------------------------------------------------------------------
# CouseTeX Simplified Latex Lightweight Open Course Web-framework
# Author: Shane Transue
#-------------------------------------------------------------------------------------
ROOT=$(PWD)
PUBLISH_DIR=publish
HTML_DIR=html
INTERMEDIATE_DIR=intermediate
IMAGE_DIR=images
PLUGIN_DIR=plugins
CSS_DIR=css
MODULE_DIR=modules
LIB_DIR=lib
CONFIG_DIR=config
MENU_DIR=menu

#-------------------------------------------------------------------------------------
# Create the publish build directory structure.
#-------------------------------------------------------------------------------------
mkdir $PUBLISH_DIR
mkdir $PUBLISH_DIR/$INTERMEDIATE_DIR
mkdir $PUBLISH_DIR/$HTML_DIR
mkdir $PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR
mkdir $PUBLISH_DIR/$HTML_DIR/$PLUGIN_DIR
mkdir $PUBLISH_DIR/$HTML_DIR/$CSS_DIR

#-------------------------------------------------------------------------------------
# The required files from the Course-TeX library are temporarily copied to the 
# execdir. These files will then be removed after the build.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type d -exec cp $CONFIG_DIR/config.cfg "{}" \;
find $MODULE_DIR/ -type d -exec cp $LIB_DIR/coursedoc.sty "{}" \;
find $MODULE_DIR/ -type d -exec cp $LIB_DIR/courseinput.sty "{}" \;
find $MODULE_DIR/ -type d -exec cp $LIB_DIR/css.sty "{}" \;
find $MODULE_DIR/ -type d -exec cp $LIB_DIR/html.sty "{}" \;
find $MODULE_DIR/ -type d -exec cp $LIB_DIR/code.sty "{}" \;
find $MODULE_DIR/ -type d -exec cp $MENU_DIR/webtitle.sty "{}" \;

#-------------------------------------------------------------------------------------
# Compile every *.tex file in the modules directory.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.tex' -execdir htlatex "{}" "config.cfg" \;

#-------------------------------------------------------------------------------------
# Convert every *.eps file into a web svg file using dvisvgm
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.eps' -execdir dvisvgm -n --zoom=1.5 -E "{}" -o "{}".svg \;

#-------------------------------------------------------------------------------------
# Move all of the temporary Latex files to the intermediate directory.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.4ct' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.4tc' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.aux' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.dvi' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.idv' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.lg' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.log' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.tmp' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.xref' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;

#-------------------------------------------------------------------------------------
# All images should be provided in the encapsulated postscript files; however
# we only want to move the converted latex images, not the users images.
#    @see tex3ht.env
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name 'convert*.eps' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy the HTML file to the publish directory.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.html' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy the CSS and PNG images to the publish directory.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.css' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$CSS_DIR/ \;
find $MODULE_DIR/ -type f -name '*.svg' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.png' -execdir cp "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.bmp' -execdir cp "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.jpg' -execdir cp "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;
find $MODULE_DIR/ -type f -name '*.jpeg' -execdir cp "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy Java-script plug-ins to the publish directory.
#-------------------------------------------------------------------------------------
cp -r $PLUGIN_DIR/dropdowntab/ $PUBLISH_DIR/$HTML_DIR/$PLUGIN_DIR/

#-------------------------------------------------------------------------------------
# Remove all of the temporary build files.
#-------------------------------------------------------------------------------------
find $MODULE_DIR/ -type f -name '*.sty' -execdir rm "{}" \;
find $MODULE_DIR/ -type f -name '*.cfg' -execdir rm "{}" \;
