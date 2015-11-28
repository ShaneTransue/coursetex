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
find modules/ -type d -exec cp config/config.cfg "{}" \;
find modules/ -type d -exec cp lib/coursedoc.sty "{}" \;
find modules/ -type d -exec cp lib/courseinput.sty "{}" \;
find modules/ -type d -exec cp lib/css.sty "{}" \;
find modules/ -type d -exec cp lib/html.sty "{}" \;
find modules/ -type d -exec cp lib/webtitle.sty "{}" \;
find modules/ -type d -exec cp lib/code.sty "{}" \;

#-------------------------------------------------------------------------------------
# Compile every *.tex file in the modules directory.
#-------------------------------------------------------------------------------------
find modules/ -type f -name '*.tex' -execdir htlatex "{}" "config.cfg" \;

#-------------------------------------------------------------------------------------
# Move all of the temporary Latex files to the intermediate directory.
#-------------------------------------------------------------------------------------
find modules/ -type f -name '*.4ct' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.4tc' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.aux' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.dvi' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.idv' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.lg' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.log' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.tmp' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;
find modules/ -type f -name '*.xref' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$INTERMEDIATE_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy the HTML file to the publish directory.
#-------------------------------------------------------------------------------------
find modules/ -type f -name '*.html' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy the CSS and PNG images to the publish directory.
#-------------------------------------------------------------------------------------
find modules/ -type f -name '*.css' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$CSS_DIR/ \;
find modules/ -type f -name '*.png' -execdir mv "{}" $ROOT/$PUBLISH_DIR/$HTML_DIR/$IMAGE_DIR/ \;

#-------------------------------------------------------------------------------------
# Copy Java-script plug-ins to the publish directory.
#-------------------------------------------------------------------------------------
cp -r $PLUGIN_DIR/dropdowntab/ $PUBLISH_DIR/$HTML_DIR/$PLUGIN_DIR/

#-------------------------------------------------------------------------------------
# Remove all of the temporary build files.
#-------------------------------------------------------------------------------------
find modules/ -type f -name '*.sty' -execdir rm "{}" \;
find modules/ -type f -name '*.cfg' -execdir rm "{}" \;
