import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 700;

//Textures
PImage bgTexture, heartTexture;
PImage[] carTextures, starTextures;

//Tailles
int carWidth, carHeight;
int starWidth, starHeight;
int heartWidth, heartHeight;

//Jeu
int gameState, lives, score, deathCooldown;
int timeElapsed, startingTime;

//Personnage
PVector carPos;
int carDir, carType;
final float carVelocity = 8;

//Etoiles
ArrayList<Star> stars;
ArrayList<Star> starsToRemove;
final float starVelocity = 8.5;
final int cooldownStar = 20;
int timeLeftStar;
