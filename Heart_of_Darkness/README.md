Based on below instructions from <https://www.myabandonware.com/game/heart-of-darkness-a4h>.
Found a base `hode.ini` file at <https://github.com/tuxuser/hode/blob/1.0.0.1/WinRT/hode.ini>.

1) Download Hode, a rewrite of the engine. http://cyxdown.free.fr/hode/.
hode-0.2.9-win32.zip is the file you need, at the bottom of the page.
Extract the files into a folder.

2) Download the x86 version of SDL2.dll.
https://github.com/libsdl-org/SDL/releases/tag/release-2.26.1.
Extract the files into the same folder with Hode files.

3) Download both RIP and ISO versions of the game.
Extract the folder of the RIP version and put it in the folder with Hode files.
Now, open the extracted folder and go to paf folder. Delete hod.paf.
Open the ISO version, go to paf folder, copy hod.paf and paste in the paf folder of the RIP version.

4) The game will run faster, if you want the original game speed open hode.ini and change the frame duration from 50 to 80. Also in the game an image smoothing algorithm is applied, if you want something more faithful to the original graphics try to change it through the hode.ini file in the scaling algorithm option.

5) Run the game with hode.exe.
