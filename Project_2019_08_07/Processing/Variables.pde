import processing.serial.*;
Serial myPort;

//Fenêtre
final int W = 300;
final int H = 600;

//Textures
PImage bgTexture;
PImage[] starTextures, starDarkTextures;

//Tailles
int starWidth, starHeight;

//Jeu
int gameState;
int score;
int deathCooldown;
int[] oldValue;
int hit, total;
float hp;

//Etoiles
int[] Xpos;
final int Ypos = 450;
final float starSpeed = 3.7;
ArrayList<Star> stars;
ArrayList<Star> starsToRemove;
final int minStarCD = 23, maxStarCD = 35;
int starTimeLeft;

//Textes
ArrayList<Text> texts;
ArrayList<Text> textsToRemove;
