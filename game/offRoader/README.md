Link to youtube presentation: https://youtu.be/lsv93LP1mr0

User's Manual:
1: Downloading necessarry components:
    1.1 Install the appropriate version of Love2d from this page: https://love2d.org/

    1.2 Make sure Love2d is installed in "applications"

2: Starting the program:

    I found this info at https://love2d.org/wiki/Getting_Started and the Mac section works for me.

    2.1 Love2d works differently for different operating systems. I used Mac OS X so I reccommend doing the same. I will try to explain it for Linux and Windows as well.

    2.2 Mac OS X: Drag the code file 'offRoader' from the .zip onto your Love2d file.
        2.21 If the above does not work, execute "open -n -a love X" in your computer's terminal, where X is the path to offRoader. (I used Mac and had to use this method)2.22 You can find the path to the offRoader file, search for it in Finder. Right-click on it, then hold option and select "copy as pathname" to copy it to your clipboard.

    2.3 Linux: execute "love X" in your terminal, where X is the path to offRoader. If that doesn't work, try using the path to the entire game package instead.

    2.4 Windows: Drag the 'offroader' file onto love.exe.

3: playing the game:

    3.1 Objective: You are the blue rocket with the star on it. Your job is to avoid the green space-ogres flying at you from the edges of the screen. Also avoid the asteroids. Ogres will explode on impact and take 1 life from the player (you start with 3 life and lose at 0). Each ogre destroyed will count towards your score, and more ogres and asteroids spawn per second as the score increases. Ogres which explode damaging you do not count towards your score. Once you lose (by having 0 life or getting hit by an asteroid), the game instantly restarts.

    3.2 Controls: 
        3.21 w,a,s,d are to move. Move the mouse to aim (see 3.22).
        3.22 Left click fires a projectile from the player in the direction of the mouse pointer.
        3.33 Press spacebar or right click (whichever is more convenient) to fire a missile which travels directly to the mouse's destination and detonates, causing a large explosion which destroys ogres but does not hurt asteroids or the player. You start the game with one of these and must pick up more once you run out.

    3.3 Power-Ups
        3.1 Rarely (1/20), ogres will drop extra missiles on death which can be picked up by the player to add to their arsenal. Move over a dropped missile icon to pick it up.
        3.2 Even more rarely (1/40), ogres will drop an extra life on death. Move over it to pick it up, but you cannot pick up extra life if you are already at 3 life.