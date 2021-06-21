import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 500;

//Textures
PImage bgTexture, carTexture, fireballTexture, heartTexture;
PImage[] slimeTextures;

//Tailles
int carWidth, carHeight;
int fbWidth, fbHeight;
int slimeWidth, slimeHeight;
int heartWidth, heartHeight;

//Jeu
int gameState, score, kills, lives, deathCooldown;

//Personnage
float carAngle;
int carTimeLeft;
final int carCooldown = 5;

//Fireball
ArrayList<Fireball> fireballs;
ArrayList<Fireball> fireballsToRemove;
final float fireballVelocity = 10;

//Slimes
ArrayList<Slime> slimes;
ArrayList<Slime> slimesToRemove;
final float slimeVelocity = 4;
int slimeCooldown;
int slimeTimeLeft;
final int maxSlimeCD = 100;
final int minSlimeCD = 30;
