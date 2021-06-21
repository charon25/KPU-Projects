import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 600;
final float maxDistance = H * sqrt(2);

//Textures
PImage bgTexture, enemyTexture, warningTexture;
PImage[] carTextures;

//Tailes
int carWidth, carHeight;
int enemyWidth, enemyHeight;

//Jeu
int gameState, lives, timeElapsed, startingTime, deathCooldown;
float score;

//Personnage
float carAngle, carDistance;
int carDir, carTexture;
final int carVelocity = 6, maxCarDistance = int(H * 0.4);

//Ennemis
ArrayList<Enemy> enemies;
ArrayList<Enemy> enemiesToRemove;
final float enemyVelocity = 12;
final int enemyCooldown = 30, enemyWarningTime = 30;
int timeLeftEnemy;
