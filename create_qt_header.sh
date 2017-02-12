#!/bin/bash

#Goal: use qt uic to generate new h file, and backup current h file. edit location if neccessary

echo "backing up current qt header file..."
mv /home/sub/workspace/winch_gui/client/include/winch_gui.h /home/sub/workspace/winch_gui/client/include/winch_gui_backup.h

echo "generating new qt header file..."
uic /home/sub/workspace/winch_gui/client/resource/ui/winch_gui.ui -o /home/sub/workspace/winch_gui/client/include/winch_gui.h

#echo "deleting old gui build files..."
#rm -r ~/catkin_ws/build/robotican/robotican_gui/

echo "done."
