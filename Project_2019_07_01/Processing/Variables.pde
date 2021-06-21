import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 750;

//Textures
PImage bgTexture;
PImage[] carIdleTextures, carAttackTextures;
PImage[] obsTextures;
PImage[] ennIdleTextures, ennAttackTextures;
PImage[] shotTextures;
PImage heartTexture;

//Tailles
int carWidth, carHeight;
int ennWidth1, ennWidth2, ennHeight1, ennHeight2;
int shotWidth, shotHeight;
int heartWidth, heartHeight;

//Jeu
int gameState, deathCooldown;
int level, lives, kills;

//Personnage
final int carVelocity = 4, carAttackCooldown = 15;
PVector carPos;
int carDir;
boolean isMovingCar;
int carAttackTimeLeft;
int invincibilityLeft;

//Obstacles
ArrayList<Obstacle> obstacles;

//Ennemis
ArrayList<Enemy> enemies;
ArrayList<Enemy> enemiesToRemove;
final int enemyAttackCooldown = 250;

//Shot
ArrayList<Shot> shots;
ArrayList<Shot> shotsToRemove;
final int shotVelocity = 7;
