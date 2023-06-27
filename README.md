# MyFirstAsteroid
#### Video Demo:  <https://youtu.be/nQAiUIJXNd8>

## A simple asteroid clone

## Credits and resources:
#### 
- [love2d](https://love2d.org) for the love2d framework
- [love2d wiki](https://love2d.org/wiki/Main_Page) and invaluable resource for using love2d
- [HUMP](https://github.com/vrld/hump#readme) for 'Push' and 'Class'
- [simplegametutorials](https://simplegametutorials.github.io/love/) for ideas on how to build the game and the math i used for angles and collision detection
- I also used a very basic state machine written by Colton Ogden rather than the one in HUMP because it was much simpler and provided all the functionality I needed.

## States
#### 
My game uses four basic states.
- A title screen with instructions on how to play
- A countdown before play actually starts
- A play state where all the gameplay takes place.
- A game over state which displays your score
- I also used a base state to be included in the other states to cut down on redundancy
Several of the in-game stats like the number of lives, what level the player, or how many points till the next extra life are passed on between states.

The basic loop is title > countdown > gameplay > game over


## Gameplay
#### 
Upon loading, the player is presented with a welcome screen which explains the game controls. They hit enter and are presented with a three second countdown before their ship is placed in the center of the screen and the first asteroid is randomly generated. A number of asteroids equal to the current level are generated with randomised speed, rotation, and travel in a random direction. 

When the player shoots an asteroid it breaks into multiple smaller asteroids with their own random directions, speeds, and rotations. These smaller asteroids can also be broken down until they disappear entirely at which point they are given another countdown before the next level with more asteroids. 

The player earns points based on the size of the asteroids they hit with smaller targets giving more points and every 1000 points grants them an extra life.

If the player crashes into a rock, they lose one life and respawn at the center of the screen. After respawn they cannot be hit by asteroids until they shoot or move. 

When the player crashes with no remaining lives they're taken to a game over screen that displays their final score.

