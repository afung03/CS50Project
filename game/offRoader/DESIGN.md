Technical Decisions:

I decided to implement my project in Lua using the Love2d library after hearing about it from the CS50 website. I liked the simplictiy of the program and how it was easy to think about. Basically, main.lua runs on 3 functions: load, update, and draw, which initialize the game, update variables periodically, and then draw them onto the screen, respectively. Variables in the load function can be calles in any other file and other files can be accessed easily as long as 'require "filename"' is in 
love.load. The love.graphics library made it easy to use png files for in-game objects and the background.

The Files:

Each object has a specific image file and .lua file associated with it. Non-player objects are often placed into lists, which makes it easier to iterate over, create multiples, and reamove or add those objects. Using the 'table.insert(tablename, variable)' function, new objects can easily be added to the game via functions inserting them into the right list. the 'for i,v in ipairs(list)' method allows one to call both the index (i) and the value of i (v) in a for loop, making it easy to iterate over every object which shares a type and pop its index if needed. Object files have a similar structure to main.lua except with an object:new() function instead of a load function to initialize variables.

Aside from load, update, and draw, specific events (like keypressed and mousepressed) can be set up to trigger in main.lua. These allow the player to impace the game. Movement and positioning is handled by storing x and y coordinates for each object, updating them with the update function, and passing them to the draw function. Usually referred to as self.x and self.y, these coordinates are initialized at the start of the file as the object's starting coordinates. All movement is multiplied by dt to keep it consistent across different framerates, and so the game does not move at lightning speed.

Gameplay:

Collisions are detected using the pythagorean theorem to determine if an object is within a near enough radius to another. One must iterate over the entire list of objects of a relevant type for each one object it senses a collision with. All hitboxes are circular to make the game easier and more consistent to play. Also, chain shapes were broken in the love.physics library (as you can read at the top of this page: https://love2d.org/wiki/love.physics.newChainShape), so it would have been exceedingly difficult to detect collisions using the shape of the .png file for each object. halfHeight and halfWidth are initialized in the new() function for most objects because they are useful in both the pythagorean theorem and the draw function, which uses theve values to center the rotation and scaling of the image on its center.

Difficulty is initialized in an array in the love.load function. Spawns for ogres and meteors are determined by adding dt to a variable with each frame and then checking if that variable is less than a constant (the constant decreases as difficulty increases). The update function handles adding to the spawning variables and checking to see if the score has reached a threshold at which the difficulty increases.

Sources:

I created all graphics myself using Kapwing, a free online image creator, using shapes in their 'elements' section.

I use a library called 'classic' to define the class object and its attributes, which was created by user 'rxi' on github and can be found here: https://github.com/rxi/classic/blob/master/classic.lua. The classic library is listed in the code files as 'classic.lua'. The rest of the files were created by me.

In general, Sheepolution's Guide to Love https://sheepolution.com/learn/book/contents was a big help in understanding the structure of Love2d games and https://love2d.org/wiki helped me find specific functions.