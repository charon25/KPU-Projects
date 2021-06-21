import processing.serial.*;
Serial myPort;

//Fenêtre
final int H = 599;
final float buildingSpace = 53.75;

//Textures
PImage bgTexture, resistanceTexture, frameTexture, smallFrameTexture, upgradeTexture;
PImage[] buildingTextures;

//Tailles
int resWidth, resHeight;
int buildingWidth, buildingHeight;
int upgradeWidth, upgradeHeight;

//Jeu
int gameState, playState, startTime;
double resistances;
float resSize;
boolean cancelNextOne, given;
float resPerSecond;

//Bâtiments
int selectedBuilding;
final int NUMBER_OF_BUILDINGS = 6;
final double[] buildProductions = {0.1, 1.5, 22.5, 337.5, 5062.5, 75937.5};
double[] buildPrices = {20, 100, 600, 4200, 336000, 5000000};
int[] upgradeN;
double[] upgradePrices = {100, 500, 3000, 21000, 1680000, 25000000}; 
final String[] buildNames = {"Children", "Farm", "Mine", "Factory", "Rocket", "Worm hole"};
int[] buildN;
